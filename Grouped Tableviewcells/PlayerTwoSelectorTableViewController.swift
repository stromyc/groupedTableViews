//
//  PlayerTwoSelectorTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class PlayerTwoSelectorTableViewController: UITableViewController {

	
	// playerInfoEntity created at viewDidload or passed in from VC segue.
	var playerInfo : PlayerInfo<PlayerInfoEntity>?
	var playerInfoList = Array<PlayerInfoEntity>()
	// Check to see if playerInfo
	var playerInfoPreSet: Bool = false
	
	var playerTwoEntity: PlayerInfoEntity?
	var playerTwoSelectedEntity: PlayerInfoEntity!
	
	
	
	
	
//	var playerInfo = PlayerInfo()
//	var playerInfoList = Array<PlayerInfoEntity>()
//	
//	var playerTwoSelectedEntity: PlayerInfoEntity!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if playerInfo == nil {
			self.playerInfo = PlayerInfo()
			self.playerInfo!.getAllEntitiesByDisplayOrder()
			// Returns an array of PlayerInfoEntities matched by ClubId
		}
		
		
		

		//self.playerInfo.getAllEntitiesByDisplayOrder()
		// Returns an array of PlayerInfoEntities matched by ClubId

		//let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
		//let playerClubMatchingPredicate = NSPredicate(format: "clubID = %@", "Woodside")
		
		self.playerInfoList = self.playerInfo!.getAllEntitiesByDisplayOrder()
		
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
		guard let numberOfRowsInSect = self.playerInfo?.entityList.count else {
			print("PlayerInfo not Set for TableView numberOfRowsInSection !!")
			return 0
		}
		return numberOfRowsInSect
		
		
		
		//return self.playerInfo.entityList.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("playerTwoCell", forIndexPath: indexPath)
		
		guard let playerInfoEnity = self.playerInfo?.entityList[indexPath.row] else {
			print("No playerInfoEnity for cellForRowAtPath")
			return cell
		}
		
		
		//let playerInfoEnity = self.playerInfo.entityList[indexPath.row]
		cell.textLabel?.text = playerInfoEnity.name
		cell.detailTextLabel?.text = playerInfoEnity.clubID
		//cell.textLabel?.text = "Test of table View"
		return cell
	}
	

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "unwindSetPlayerTwoName" {
			
			let indexPath = self.tableView.indexPathForSelectedRow
			print("index path: \(indexPath)")
			// Save the ShipmentEntity for this row
			// on the ShipmentViewController
			self.playerTwoSelectedEntity = self.playerInfo!.entityList[indexPath!.row] //FIX this with guard
			//self.playerInfoList[indexPath!.row]
			
			// Save the Shipment business controller
			// on the ShipmentViewController
			//self.playerInfo = self.playerInfo
			print("Unwind save two called")
			
		}
		
		
		
		
	}

}
