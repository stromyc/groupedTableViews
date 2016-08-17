//
//  CreateNewPlayerViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/7/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class CreateNewPlayerViewController: UIViewController {
    
    
    @IBOutlet weak var playerNameTextDescription: UITextField!
    var newPlayerDescription: String!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindSavePlayerName" {
            self.newPlayerDescription = self.playerNameTextDescription.text
            print("newPlayer unwind segue called")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
