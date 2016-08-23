//
//  mmBusinessObject.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

public enum SaveState {
    case Error, RulesBroken, SaveComplete
}

public class mmBusinessObject<T: NSManagedObject>
{
    var dbName : String = ""
    // Gets the entity class name string from <T>
    var entityClassName : String {
        var className = NSStringFromClass(T)
        if className.rangeOfString(".") != nil {
            
            className = (className as NSString).pathExtension
        }
        return className
    }
    var copyDatabaseIfNotPresent : Bool = false
    //var error : NSError?
    
    init()
    {
    }
    
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.oakleafsd.<ProjectName>" in the application's documents Application Support directory.
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        print(urls);
        
        return urls[urls.count-1]
    }()
    
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    lazy public var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        //managedObjectContext.stalenessInterval = 0.0
        
        return managedObjectContext
    }()
    
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let modelURL = NSBundle.mainBundle().URLForResource(self.dbName, withExtension: "momd")!
        var model: NSManagedObjectModel? = NSManagedObjectModel(contentsOfURL: modelURL)
        return model!
    }()
    
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        
        let url : NSURL = self.getStoreURL()
        
        if self.copyDatabaseIfNotPresent
        {
            let dbcPath = url.path!
            var fileManager = NSFileManager.defaultManager()
            
            // Check if the sqlite database already exists
            if !fileManager.fileExistsAtPath(dbcPath)
            {
                // It doesn't. Check if a .sqlite database was distributed with this app
                var defaultStorePath = NSBundle.mainBundle().pathForResource(self.dbName, ofType: "sqlite")
                if defaultStorePath != nil
                {
                    // It was, copy the embedded database to the app's Documents directory
                    do {
                        try fileManager.copyItemAtPath(defaultStorePath!, toPath: dbcPath)
                    }
                    catch  {
                        //print((error as NSError).localizedDescription)
                    }
                }
            }
        }
        
        // Create the coordinator and store
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true])
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            //dict[NSUnderlyingErrorKey] = error as! NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    func getStoreURL() -> NSURL {
        return self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.dbName).sqlite")
    }
    
    // Saves changes to all entities
    public func saveEntities() -> (state: SaveState, message: String?)
    {
        
        print("saveEntites is called")
        var saveState: SaveState
        var saveMessage: String?
        
        // Business rules passed
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            }
            catch let error as NSError {
                
                saveState = SaveState.Error
                saveMessage = error.localizedDescription
                print("didnot save because: \(saveMessage)")
            }
            saveState = SaveState.SaveComplete
            saveMessage = nil
        }
        else {
            saveState = SaveState.SaveComplete
            saveMessage = nil
        }
        
        return (saveState, saveMessage)
    }
    
    // Register a related business controller object
    // This causes them to use the same object context
    func registerChildObject(controllerObject: mmBusinessObject)
    {
        controllerObject.managedObjectContext = self.managedObjectContext
    }
    
    // Gets all entities of the default type
    public func getAllEntities() -> Array<T>
    {
        return self.getEntities(sortedBy: nil, matchingPredicate: nil)
    }
    
    // Get all entities sorted by the descriptor and matching the predicate
    func getEntities(sortedBy sortDescriptor:NSSortDescriptor?, matchingPredicate predicate:NSPredicate?) -> Array<T>
    {
        // Create the request object
        let request : NSFetchRequest = NSFetchRequest()
        var list = Array<T>()
        
        // Set the entity type to be fetched
        let entityDescription : NSEntityDescription! = NSEntityDescription.entityForName(self.entityClassName, inManagedObjectContext: self.managedObjectContext)
        
        request.entity = entityDescription
        
        if predicate != nil
        {
            
            request.predicate = predicate
        }
        
        if let descriptor = sortDescriptor
        {
            request.sortDescriptors = [descriptor]
        }
        
        // Execute the fetch
        do {
            print("fecthis executed")
            list = try self.managedObjectContext.executeFetchRequest(request) as! Array<T>
            
        }
        catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        return list
        
    }
    
    // Gets all entities sorted by descriptor
    func getAllEntitiesSortedBy(sortDescriptor:NSSortDescriptor) -> Array<T>
    {
        return self.getEntities(sortedBy: sortDescriptor, matchingPredicate: nil)
    }
    
    // Get entities of the default type matching the predicate
    func getEntitiesMatchingPredicate(predicate: NSPredicate) -> Array<T>
    {
        return self.getEntities(sortedBy: nil, matchingPredicate: predicate)
    }
    
    // Get entities of the default type sorted by descriptor and matching the predicate
    func getEntitiesSortedBy(sortDescriptor: NSSortDescriptor, matchingPredicate predicate:NSPredicate) -> Array<T>
    {
        return self.getEntities(sortedBy: sortDescriptor, matchingPredicate: predicate)
    }
    
    // Save changes to the specified entity
    func saveEntity(entity: T) -> (state: SaveState, message: String?)
    {
        var saveState: SaveState
        var saveMessage: String?
        
        // Check the business rules
        saveMessage = self.checkRulesForEntity(entity)
        
        if saveMessage == nil
        {
            let result = self.saveEntities()
            saveState = result.state
            saveMessage = result.message
        }
        else
        {
            // Business rules failed
            saveState = SaveState.RulesBroken
        }
        return (state: saveState, message: saveMessage)
    }
    
    // Adds the list of entities to this business object context
    func addEntitiesToObjectContext(entityList: Array<T>)
    {
        for entityOriginal: T in entityList
        {
            let keys = Array(entityOriginal.entity.attributesByName.keys)
            let dictionary = entityOriginal.dictionaryWithValuesForKeys(keys)
            let entityCopy = self.createEntity()
            entityCopy.setValuesForKeysWithDictionary(dictionary)
        }
    }
    
    // Create a new entity of the default type
    func createEntity() -> T
    {
        return NSEntityDescription.insertNewObjectForEntityForName(self.entityClassName, inManagedObjectContext: self.managedObjectContext) as! T
    }
    
    // Mark the specified entity for deletion
    func deleteEntity(entity: T)
    {
        self.managedObjectContext.deleteObject(entity)
    }
    
    func checkRulesForEntity(entity: NSManagedObject) -> String?
    {
        return nil
    }
    
}
