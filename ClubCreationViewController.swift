//
//  ClubCreationViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/3/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class ClubCreationViewController: UIViewController {
    
    @IBOutlet weak var clubNameTxtDescription: UITextField!
    var newClubDescription: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clubNameTxtDescription.becomeFirstResponder()
        // Do any additional setup after loading the view.
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindSaveNewClub" {
            self.newClubDescription = self.clubNameTxtDescription.text 
        }
    }
    // and return the new entity to the caller
//    func addClubToList(name: String) -> ClubEntity {
//        let clubEntity = self.createEntity()
//        toDoEntity.desc = name
//        toDoEntity.displayOrder = self.entityList.count + 1
//        self.saveEntities()
//        self.entityList.append(toDoEntity)
//        return toDoEntity
//    }

}
