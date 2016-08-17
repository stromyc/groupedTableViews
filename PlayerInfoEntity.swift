//
//  PlayerInfoEntity.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

@objc(PlayerInfoEntity)
class PlayerInfoEntity: NSManagedObject {
    
    @NSManaged var clubID: String?
    @NSManaged var draws: NSNumber?
    @NSManaged var email: String?
    @NSManaged var losses: NSNumber?
    @NSManaged var name: String
    @NSManaged var score: NSNumber
    @NSManaged var wins: NSNumber?
    @NSManaged var latestResult: String?
    @NSManaged var displayOrder: NSNumber
    @NSManaged var club: NSManagedObject?
    @NSManaged var playerMatchRecord: NSManagedObject?    
   
    
    
    
}