//
//  ScoringTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit
//datePickerCell = NSIndexPath(forRow: 1, inSection: 2)

enum PlayerScoringSection: Int {
	case PlayerOneAndTwoSelector,  MatchWinner, MatchDate, MatchOutcome, CalculateResults
	static let allValues = [PlayerOneAndTwoSelector, MatchWinner, MatchDate, MatchOutcome, CalculateResults]
}

class ScoringTableViewController: UITableViewController {
	
    // Stores selected player info entity.
	var playerInfo: PlayerInfo<PlayerInfoEntity>!
	var playerOneEntity: PlayerInfoEntity!
	var playerTwoEntity: PlayerInfoEntity!
    
	
	// Date pickerCell
    var datePickerCell : NSIndexPath?
    var rows = 0
    var dateCellRows = 1
    
    var dateFormatter = NSDateFormatter()
	

	// Scoring Calculator
	var eloCalculator = EloCalculator()
	
	@IBAction func calculateScoresButton(sender: UIButton!) {
		
		
		let newScores =  eloCalculator.scoreOpponents(playerOneEntity, playerTwo: playerTwoEntity, kFactor: .thirty)
		let playerOneUpdatedScore = newScores.playerOneNewScore
		let playerTwoUpdatedScore = newScores.playerTwoNewScore
		print("player 1 old score: \(playerOneEntity.score)")
		print(playerOneUpdatedScore)
		print("player 2 old score: \(playerTwoEntity.score)")
		print(playerTwoUpdatedScore)
	}
	
	// Player one selection outlet.
	@IBOutlet var playerOneCellLabel: UILabel!
	var playerOneCellText : String!

    // Player two selection outlet.
	@IBOutlet var playerTwoCellLabel: UILabel!

	
	
	
	
	
	
	
    @IBAction func cancelSelectPlayerOneSegue(segue:UIStoryboardSegue){
		print("cancelCreatePlayer function called.")
	}
    	
    // Sets player one after selecting from list of players.
	@IBAction func unwindSetPlayerOneName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerOneSelectorTableViewController
        
        // Sets the selected playerOneEntity
        self.playerOneEntity = tvc.playerOneSelectedEntity
        
		self.playerOneCellLabel.text = tvc.playerOneSelectedEntity.name
	}
	
	@IBAction func unwindSetPlayerTwoName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
        
        // Sets the selected playerTwoEntity
        self.playerTwoEntity = tvc.playerTwoSelectedEntity
        
		self.playerTwoCellLabel.text = tvc.playerTwoSelectedEntity.name
	
	}
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

  

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var rowHeight = tableView.rowHeight
        
        if indexPath == datePickerCell {
			
				rowHeight = 160
			}
        return rowHeight
    }
	
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case PlayerScoringSection.PlayerOneAndTwoSelector.rawValue :
            rows = 2
        case PlayerScoringSection.MatchWinner.rawValue :
            rows = 1
        case PlayerScoringSection.MatchDate.rawValue :
			// rows adjusted with datePicker in view or out of view.
            rows = dateCellRows
		case PlayerScoringSection.MatchOutcome.rawValue :
			rows = 3
		case PlayerScoringSection.CalculateResults.rawValue :
			rows = 2
        default:
            rows = 1
        }
		
        return rows
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        
       
        //Inline DatePicker
       
        if indexPath.section == 2 {
            
            
            
            if datePickerCell == nil {
            dateCellRows = dateCellRows + 1
            datePickerCell = NSIndexPath(forRow: 1, inSection: 2)
            tableView.insertRowsAtIndexPaths([datePickerCell!], withRowAnimation: .Top)
			print("section two pressed")
            
            
            } else {
        
			dateCellRows = dateCellRows - 1
            tableView.deleteRowsAtIndexPaths([datePickerCell!], withRowAnimation: .Top)
            print("Section two pressed to remove")
            datePickerCell = nil
            }
        }
        
        tableView.endUpdates()
    }
}
