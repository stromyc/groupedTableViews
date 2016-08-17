//
//  ABusinessObject.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation
import CoreData

class ABusinessObject<T: NSManagedObject>:
mmBusinessObject<T> {
    
    override init() {
        super.init()
        
        self.dbName = "groupedTableviewCells"
        self.copyDatabaseIfNotPresent = true
    }
    
}
