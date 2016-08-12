//
//  ScoringTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit


enum PlayerScoringSection: Int {
	case PlayerOneSelector, PlayerTwoSelector, MatchWinner, MatchDate
	static let allValues = [PlayerOneSelector, PlayerTwoSelector, MatchWinner, MatchDate]
}

class ScoringTableViewController: UITableViewController {
	
	var playerInfo: PlayerInfo<PlayerInfoEntity>!
	var playerOneEntity: PlayerInfoEntity!
	var playerTwoEntity: PlayerInfoEntity!
	
	@IBAction func cancelSelectPlayerOneSegue(segue:UIStoryboardSegue){
		print("cancelCreatePlayer function called.")
	}


	@IBOutlet var playerOneCellLabel: UILabel!
	var playerOneCellText : String!

	@IBOutlet var playerTwoCellLabel: UILabel!
	
	@IBAction func unwindSetPlayerOneName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerOneSelectorTableViewController
		self.playerOneCellLabel.text = tvc.playerOneSelectedEntity.name
		print(tvc.playerOneSelectedEntity.name)
		
		print(" select player one called")
	}
	
	@IBAction func unwindSetPlayerTwoName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
		self.playerTwoCellLabel.text = tvc.playerTwoSelectedEntity.name
		print(tvc.playerTwoSelectedEntity.name)
		
		print(" select player tw0 called")
	}
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	
}
