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
