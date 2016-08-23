//
//  Club.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData


class Club<T: ClubEntity>: ABusinessObject<T> {

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


    
    // Create a new entity with the specified description, add it to the list
    // and return the new entity to the caller
    func addItemToList(desc: String) -> ClubEntity {
        let clubEntity = self.createEntity()
        clubEntity.clubName = desc
        clubEntity.displayOrder = self.entityList.count + 1
        self.saveEntities()
        print(self.saveEntities().message)
        self.entityList.append(clubEntity)
        return clubEntity
    }
    

}
