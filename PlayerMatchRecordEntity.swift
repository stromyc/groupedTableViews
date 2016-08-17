//
//  PlayerMatchRecordEntity.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

class PlayerMatchRecordEntity: NSManagedObject {
    
    @NSManaged var playerMatchRecord: NSObject?
    @NSManaged var matchOutcomeString: String?
    @NSManaged var matchOutcomeDate: NSDate?
    @NSManaged var playerInfo: NSSet?

}
