//
//  PlayerInfo.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData


class PlayerInfo<T:PlayerInfoEntity>: ABusinessObject<T> {

// Insert code here to add functionality to your managed object subclass
    var entityList: Array<T>!
    
    override init() {
        super.init()
    }
    
    // Get all entities sorted by display order
    func getAllEntitiesByDisplayOrder() -> Array<T> {
        
        let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
        self.entityList = self.getAllEntitiesSortedBy(sortDescriptor)
        return self.entityList!
    }
    
    
    func getPlayersForClubID (clubID: String) -> Array<T> {
        
        let predicate = NSPredicate(format:
            "clubID = %@", clubID)
        self.entityList = self.getEntitiesMatchingPredicate(predicate)
        
        return self.entityList!
        
    }
    
    
    
    
    
//    func getAllPlayersByClub() -> Array<T> {
//        
//        let sortDescriptor = NSSortDescriptor(
//    }
    
    // Move the object at the source index path to the destination index path
    func moveObjectAtIndexPath(sourceIndexPath: NSIndexPath, destinationIndexPath: NSIndexPath) {
        
        let from = sourceIndexPath.row
        let to = destinationIndexPath.row
        
        if from == to {
            return
        }
        
        // Get the entity to be reordered, remove it from
        // its old position and add it in its new position
        let toDoEntity = self.entityList[from]
        self.entityList.removeAtIndex(from)
        self.entityList.insert(toDoEntity, atIndex: to)
        
        // Set the new order of the object
        var lower = 0.0
        var upper = 0.0
        
        // Check for an item before it
        if to > 0 {
            lower = Double(self.entityList[to-1].displayOrder)
        }
        else {
            lower = Double(self.entityList[1].displayOrder) - 2.0
        }
        
        // Check for an item after it
        if to < self.entityList.count - 1 {
            upper = Double(self.entityList[to + 1].displayOrder)
        }
        else {
            upper = Double(self.entityList[to - 1].displayOrder) + 2.0
        }
        
        // Add the upper and lower, divide by two
        // to derive the new order
        let newOrder = (lower + upper) / 2.0
        toDoEntity.displayOrder = newOrder
    }
    
    // Remove the object at the specified index path
    func removeObjectAtIndexPath(indexPath: NSIndexPath) {
        self.entityList.removeAtIndex(indexPath.row)
    }
    
    // Create a new entity with the specified description, add it to the list
    // and return the new entity to the caller
    func addItemToList(desc: String, club: String) -> PlayerInfoEntity {
        print("addItemToListcalled")
        let playerInfoEntity = self.createEntity()
        playerInfoEntity.name = desc
        playerInfoEntity.clubID = club
        
        let playerWithClub = playerInfoEntity.club
        playerWithClub?.setValue("TEST OF THE CLUB", forKeyPath: "clubName")

        
        
        
        playerInfoEntity.displayOrder = self.entityList.count + 1
        self.saveEntities()
        self.entityList.append(playerInfoEntity)
        return playerInfoEntity
    }
    
//    func addItemToList(desc: String) -> PlayerInfoEntity {
//        print("addItemToListcalled")
//        let playerInfoEntity = self.createEntity()
//        playerInfoEntity.name = desc
//        //playerInfoEntity.clubID = club
//        playerInfoEntity.displayOrder = self.entityList.count + 1
//        self.saveEntities()
//        
//        self.entityList.append(playerInfoEntity)
//        return playerInfoEntity
//    }

    
    
    
    // Delete the specified entity
    override func deleteEntity(entity: T) {
        super.deleteEntity(entity)
        self.saveEntities()
    }
 
    
    
    // Creates a subset of players from each club. This will return an array of matching clubs.
    
    // Take this list and than pass back a player to the club with the clubID matching the club name.
    
       
    
    
    
    
    

}
