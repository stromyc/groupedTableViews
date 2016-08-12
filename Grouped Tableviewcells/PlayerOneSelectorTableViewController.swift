//
//  PlayerOneSelectorTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit
import CoreData

class PlayerOneSelectorTableViewController: UITableViewController {
	
	
	
	var playerInfo = PlayerInfo()
	var playerInfoList = Array<PlayerInfoEntity>()
	
	var playerOneSelectedEntity: PlayerInfoEntity!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.playerInfo.getAllEntitiesByDisplayOrder()
		// Returns an array of PlayerInfoEntities matched by ClubId
		
		//let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
		//let playerClubMatchingPredicate = NSPredicate(format: "clubID = %@", "Woodside")
		
		self.playerInfoList = self.playerInfo.getAllEntitiesByDisplayOrder()
 
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
        return self.playerInfo.entityList.count
    }

	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerOneCell", forIndexPath: indexPath)

		let playerInfoEnity = self.playerInfo.entityList[indexPath.row]
		cell.textLabel?.text = playerInfoEnity.name
		cell.detailTextLabel?.text = playerInfoEnity.clubID
		//cell.textLabel?.text = "Test of table View"
		return cell
    }
	

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "unwindSetPlayerOneName" {
						
			let indexPath = self.tableView.indexPathForSelectedRow
			print("index path: \(indexPath)")
			// Save the ShipmentEntity for this row
			// on the ShipmentViewController
			self.playerOneSelectedEntity = self.playerInfo.entityList[indexPath!.row]
			//self.playerInfoList[indexPath!.row]
			
			// Save the Shipment business controller
			// on the ShipmentViewController
			//self.playerInfo = self.playerInfo
			print("Unwind save one called")

		}
		
		
	}

}
