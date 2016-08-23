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

class ScoringTableViewController: UITableViewController{
	
	
	// create a playerInfo object pass it to vc's in segues, pass it back!
	
	
//	var eloCalculator = EloCalculator()
	
	
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
	
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print("The playerOne Entity: \(self.playerOneEntity)")
		print("The PlayerTwo Eniity: \(self.playerTwoEntity)")
	}
	
	
	
	@IBAction func calculateScoresButton(sender: AnyObject!) {
		print("calcButton play1 score: \(playerOneEntity.score)")
		print("calcButton play1 score: \(playerTwoEntity.score)")
		
	let oldScoreA = playerOneEntity.score
	let oldScoreB = playerTwoEntity.score
		
		// Returns selected outcome of match
		let matchOutCome = winLoseDrawSelection(selectWinLoseDrawSegmentedButton)
		
		// Returns selected kFactor of match
		let kFactor = kFactorSelection(selectKFactorSegmentedButton)
		
		let calcNewPlayerScores = eloCalculator.calculatePlayerScores(playerOneEntity.score as Double, playerTwoCurrentScore: playerTwoEntity.score as Double, kFactor: kFactor, matchOutcomePlayerOne: matchOutCome)
		
		
		
		
		
//	let newScores =	eloCalculator.calculatePlayerScores(playerOneEntity.score as Double, playerTwoCurrentScore: playerTwoEntity.score as Double, kFactor: KFactor.thirty)
		
		
		//let newScores =  eloCalculator.calculatePlayerScores(self.playerOneEntity, playerTwo: self.playerTwoEntity, kFactor: .thirty)
		print(eloCalculator.updateScore((calcNewPlayerScores.playerOneNewScore), playerTwo: (calcNewPlayerScores.playerTwoNewScore)))
		
		
		
		//let playerOneUpdatedScore = newScores.playerOneNewScore
		//let playerTwoUpdatedScore = newScores.playerTwoNewScore
		print("player 1 old score: \(playerOneEntity.score)")
		//print(playerOneUpdatedScore)
		print("player 2 old score: \(playerTwoEntity.score)")
		//print(playerTwoUpdatedScore)
	}
	
	// Player one selection outlet.
	@IBOutlet var playerOneCellLabel: UILabel!
	var playerOneCellText : String!

    // Player two selection outlet.
	@IBOutlet var playerTwoCellLabel: UILabel!

	
	@IBOutlet var selectWinLoseDrawSegmentedButton: UISegmentedControl!
	
	
	@IBOutlet var selectKFactorSegmentedButton: UISegmentedControl!
	
	
	@IBAction func RecordMatch(sender: AnyObject) {
		
		let newScores =	eloCalculator.calculatePlayerScores(playerOneEntity.score as Double, playerTwoCurrentScore: playerTwoEntity.score as Double, kFactor: KFactor.thirty)
		eloCalculator.updateScore(newScores.playerOneNewScore, playerTwo: newScores.playerTwoNewScore)
		
	}
	
	
	
    @IBAction func cancelSelectPlayerOneSegue(segue:UIStoryboardSegue){
		let tvc = segue.sourceViewController as! PlayerOneSelectorTableViewController
		if tvc.playerOneEntity != nil {
			self.playerOneEntity = tvc.playerOneEntity!
		}
		print("cancelCreatePlayer function called.")
	}
    	
    // Sets player one after selecting from list of players.
	@IBAction func unwindSetPlayerOneName(segue:UIStoryboardSegue) {
		let tvcOne = segue.sourceViewController as! PlayerOneSelectorTableViewController
		
	
        // Sets the selected playerOneEntity
        self.playerOneEntity = tvcOne.playerOneSelectedEntity
		self.playerInfo = tvcOne.playerInfo
		
		self.playerOneCellLabel.text = tvcOne.playerOneSelectedEntity.name
	}
	
	@IBAction func unwindSetPlayerTwoName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
        
        // Sets the selected playerTwoEntity
		
		self.playerInfo = tvc.playerInfo
		
		
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
            rows = 2
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
	
	
	
	
	
	
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
//		switch segue.identifier!  {
//		case "playerOneSegue":
//			let tvc = segue.destinationViewController as! PlayerOneSelectorTableViewController
//			
//			// Check to see if a player one has been set, if it has pass it forward to the other VC.
//			if self.playerOneEntity != nil {
//				
//				tvc.playerOneEntity = self.playerOneEntity
//				
//			}
//			
//			
//			
//		}
//
//		default:
//			print("No Segue Exists")
//		}
		
		
		if segue.identifier == "playerOneSegue" {
			
			
			let tvc = segue.destinationViewController as! PlayerOneSelectorTableViewController
			
			// Check to see if a player one has been set, if it has pass it forward to the other VC.
				if self.playerOneEntity != nil {
					
				tvc.playerOneEntity = self.playerOneEntity
					
			}
			
						print("Pass over to playerone table segue")
			
		}
		
		
		
		
		// Need to pass over the playerInfo enity to other vc and pass the same one back between various vc's to save the same
		// managed object context.
		if segue.identifier == "playerTwoSegue" {
			
			
			let tvc = segue.destinationViewController as! PlayerTwoSelectorTableViewController
			
			// Check to see if a player one has been set, if it has pass it forward to the other VC.
			if self.playerTwoEntity != nil {
				
				print("What is the value of this: \(self.playerTwoEntity)")
				tvc.playerTwoEntity = self.playerTwoEntity
				
				
				print("playeroneentity passed and not nil: \(playerTwoEntity)")
			}
			
			if self.playerInfo != nil {
				tvc.playerInfo = self.playerInfo
				print("Passed the playerInfo to VC2")
			}
			
			print("Pass over to playerone table segue")
			
		}
		
		
		
		
		
		
		
		
		
	}
	
	func kFactorSelection(kFactorControl: UISegmentedControl) -> KFactor {
		let kFactorChosen : KFactor
		
		switch kFactorControl.selectedSegmentIndex {
		case 0: kFactorChosen = KFactor.twenty
			
		case 1: kFactorChosen = KFactor.thirty
			
		case 2 : kFactorChosen = KFactor.forty
			
		default:
			kFactorChosen = KFactor.thirty
		}
		return kFactorChosen
	}
	
	

	
	func winLoseDrawSelection(winLoseDrawControl: UISegmentedControl) -> Outcome{
		
		let outComeChosen : Outcome
		
		switch winLoseDrawControl.selectedSegmentIndex
			
		{
		case 0 : outComeChosen = Outcome.win
			
		case 1 : outComeChosen = Outcome.lost
			
		default: outComeChosen = Outcome.draw
		}
		
		return outComeChosen
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
