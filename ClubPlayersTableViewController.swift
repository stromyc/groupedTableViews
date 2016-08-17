//
//  ClubPlayersTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit
import CoreData

class ClubPlayersTableViewController: UITableViewController {
    
    //Holds a reference to the PlayerInfo business controller
    var playerInfo = PlayerInfo()
    
    //Holds an array of playerInfoEntity objects
    var playerInfoList = Array<PlayerInfoEntity>()
    
    //Holds a reference to the currently selected ClubEntity object.
    
    var clubEntity : ClubEntity!
    
    
    // Pass this variable thru from perform segue from the clubListTable
    
    var titleOfPage = "No Club Name"
    var clubNameSegueValue = "No Club Name Passed"

    // Cancel button from playerCreationVC
    @IBAction func cancelCreatePlayersSegue(segue:UIStoryboardSegue){
        print("cancelCreatePlayer function called.")
    }

    // Save button pressed on playerCreationVC
    @IBAction func saveNewPlayerName(segue:UIStoryboardSegue) {
        let tvc = segue.sourceViewController as! CreateNewPlayerViewController
        
        self.playerInfo.addItemToList(tvc.newPlayerDescription, club: clubNameSegueValue)
        
        //self.playerInfo.addItemToList(tvc.newPlayerDescription)
        print("did newPlayerName xfer: \(tvc.newPlayerDescription)")
        
        let indexPath = NSIndexPath(forRow:(self.playerInfo.entityList.count - 1),
                                    inSection: 0)
        
        self.tableView.insertRowsAtIndexPaths([indexPath],
                                              withRowAnimation: UITableViewRowAnimation.Automatic)
        
        self.tableView.scrollToRowAtIndexPath(indexPath,
                                              atScrollPosition: UITableViewScrollPosition.Bottom,
                                              animated: true)
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerInfo.managedObjectContext = self.clubEntity.managedObjectContext!
        
        
        
        //self.playerInfo.getAllEntitiesByDisplayOrder()
        // Returns an array of PlayerInfoEntities matched by ClubId
        self.playerInfo.getPlayersForClubID(clubNameSegueValue)
		
		
        
        let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
        let playerClubMatchingPredicate = NSPredicate(format: "clubID = %@", "Woodside")
        
        self.playerInfoList = self.playerInfo.getEntities(sortedBy: sortDescriptor, matchingPredicate: playerClubMatchingPredicate)
        
		
    }
    
//    var fetchRequested: NSFetchRequest = {
//        let reqst = NSFetchRequest(entityName: "playerInfo")
//        let pred = NSPredicate(format: "clubID", "Woodside")
//        let sort = NSSortDescriptor(key: "displayOrder", ascending: true)
//        
//        reqst.sortDescriptors = [sort]
//        return reqst
//        
//    }()
	
//    lazy var fetchedResultsController: NSFetchedResultsController = {
//        let controller = NSFetchedResultsController(fetchRequest: s, managedObjectContext: NSManagedObjectContext, sectionNameKeyPath: <#T##String?#>, cacheName: <#T##String?#>)
//    }()
	
   
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
        //return 1
        return self.playerInfo.entityList.count
        //return playerInfoList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerName", forIndexPath: indexPath)

        // Configure the cell...
        //let playerInfoEnity = self.playerInfoList[indexPath.row]
        let playerInfoEnity = self.playerInfo.entityList[indexPath.row]
        cell.textLabel?.text = playerInfoEnity.name
        cell.detailTextLabel?.text = playerInfoEnity.clubID
        //cell.textLabel?.text = "Test of table View"
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlayerDetails" {
            
            // Get the destination view controller
            let tvc = segue.destinationViewController as! PlayerDetailTableTableViewController
            
            // Get the currently selected row
            let indexPath = self.tableView.indexPathForSelectedRow
            print("index path: \(indexPath)")
            // Save the ShipmentEntity for this row
            // on the ShipmentViewController
            tvc.playerEnity = self.playerInfo.entityList[indexPath!.row]
                //self.playerInfoList[indexPath!.row]
            
            // Save the Shipment business controller
            // on the ShipmentViewController
            tvc.player = self.playerInfo
        }
    }

    
    
    
}
