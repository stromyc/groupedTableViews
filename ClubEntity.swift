//
//  ClubEntity.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

@objc(ClubEntity)
class ClubEntity: NSManagedObject {
    
    @NSManaged var clubName: String
    @NSManaged var displayOrder: NSNumber
    @NSManaged var playersInfo: NSSet?
    @NSManaged var matchRecords: NSSet?

    
}
