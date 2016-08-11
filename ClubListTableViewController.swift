//
//  ClubListTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class ClubListTableViewController: UITableViewController {
    
    var club = Club()
    var clubList = Array<ClubEntity>()
    
    
    @IBAction func cancelClubName(segue:UIStoryboardSegue){
        print("cancelClubName function called.")
    }
    
    @IBAction func cancelClubPlayersSegue(segue:UIStoryboardSegue){
        print("cancelClubName function called.")
    }
    
    
    @IBAction func saveNewClubName(segue:UIStoryboardSegue) {
        let tvc = segue.sourceViewController as! ClubCreationViewController
        
        self.club.addItemToList(tvc.newClubDescription)
        
        let indexPath = NSIndexPath(forRow:(self.club.entityList.count - 1),
                                    inSection: 0)
        
        self.tableView.insertRowsAtIndexPaths([indexPath],
                                              withRowAnimation: UITableViewRowAnimation.Automatic)
        
        self.tableView.scrollToRowAtIndexPath(indexPath,
                                              atScrollPosition: UITableViewScrollPosition.Bottom,
                                              animated: true)
        
        
        
        
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.clubList = self.club.getAllEntities()
        self.club.getAllEntitiesByDisplayOrder()
        
        
        print(club.entityList.count)
       
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.club.entityList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClubList", forIndexPath: indexPath)

        // Configure the cell...
        
        
        //let label = cell.viewWithTag(1) as! UILabel
        
        let clubEntity = self.club.entityList[indexPath.row]
        cell.textLabel?.text = clubEntity.clubName
        //label.text = clubEntity.desc
        
        return cell


        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
  
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            if segue.identifier == "showClubPlayers"
//            {
//                if let destinationVC = segue.destinationViewController as? ClubPlayersTableViewController {
//                    destinationVC.titleOfPage = "the title segue works"
//                }
//            }
//        }
//    
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            fatalError("Unidentified segue")
        }
        
        switch identifier {
        case "showClubPlayers":
            prepareForClubPlayersDetailSegue(segue)
        case "createNewClubName":
            prepareForCreateNewClubNameSegue(segue)
        default:
            fatalError("Unexpected segue: \(identifier)")
        }
    }

    
    func prepareForClubPlayersDetailSegue(segue: UIStoryboardSegue) {
        let control = segue.destinationViewController as! ClubPlayersTableViewController
        let path = tableView.indexPathForSelectedRow!
        let clubNameEntity = self.club.entityList[path.row]
        let titleToPass = clubNameEntity.clubName
        control.titleOfPage = titleToPass
        control.clubNameSegueValue = titleToPass
    }
    
    func prepareForCreateNewClubNameSegue(segue: UIStoryboardSegue) {
        //let tempController = segue.destinationViewController as! ClubCreationViewController
                    }
    
    
    
    
    

}
