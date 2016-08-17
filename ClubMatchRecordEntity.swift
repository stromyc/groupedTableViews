//
//  ClubMatchRecordEntity.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

class ClubMatchRecordEntity: NSManagedObject {
    
    @NSManaged var date: NSDate?
    @NSManaged var matchRecords: NSObject?
    @NSManaged var matchOutcomeString: String?
    @NSManaged var club: NSManagedObject?

    
    
    
    
}
