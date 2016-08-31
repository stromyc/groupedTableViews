//
//  ScoringTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit
import CoreData

enum PlayerScoringSection: Int {
	case PlayerOneAndTwoSelector,  MatchWinner, MatchDate, MatchOutcome, CalculateResults
	static let allValues = [PlayerOneAndTwoSelector, MatchWinner, MatchDate, MatchOutcome, CalculateResults]
}

class ScoringTableViewController: UITableViewController{
	
	
    // Stores selected player info entity.
	var playerInfo: PlayerInfo<PlayerInfoEntity>!
	var playerOneEntity: PlayerInfoEntity!
	var playerTwoEntity: PlayerInfoEntity!
    
	
	// Date pickerCell
	
	
    var datePickerCell : NSIndexPath?
    var rows = 0
    var dateCellRows = 1
	
	var date = NSDate()
	var dateFormatter : NSDateFormatter = {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .ShortStyle
		return formatter
	}()
	
	func dateString() -> String {
		return dateFormatter.stringFromDate(date)
	}

	// Scoring Calculator
	var eloCalculator = EloCalculator()
	var inlineDatePicker = InlineDatePicker()
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		print("The playerOne Entity: \(self.playerOneEntity)")
		print("The PlayerTwo Eniity: \(self.playerTwoEntity)")
		
		if playerOneEntity != nil && playerTwoEntity != nil {
			calculateScoreButton.enabled = true 
		}
		
		dateOfMatchLabel.text = dateString()
	}
	
// MARK: Calculate Score for match
	
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
		
		
		let matchOutcomeIndexPath = NSIndexPath(forRow: 0, inSection: 3)
		
		let winningPath = NSIndexPath(forRow: 0, inSection: 3)
		let losingPath = NSIndexPath(forRow: 1, inSection: 3)
		let scorePath = NSIndexPath(forRow: 2, inSection: 3)
		
		
		let winNameAndLoseName = winLoseDrawWinner(selectWinLoseDrawSegmentedButton)
		switch matchOutcomeIndexPath {
		case winningPath :
			guard let cell = tableView.cellForRowAtIndexPath(winningPath) else {
				return
			}
			
			
			
			
			
			cell.textLabel?.text = "Won: \(winNameAndLoseName.winningPlayer)"
			cell.detailTextLabel?.text = ""
			fallthrough
			
		case losingPath :
			guard let cell = tableView.cellForRowAtIndexPath(losingPath) else {
				return
			}
			cell.textLabel?.text = "Lost: \(winNameAndLoseName.losingPlayer)"
			cell.detailTextLabel?.text = "Los"
			fallthrough
			
		case scorePath :
			guard let cell = tableView.cellForRowAtIndexPath(scorePath) else {
				return
			}
			cell.textLabel?.text = "Score"
			cell.detailTextLabel?.text = "Player One New score: \(calcNewPlayerScores.playerOneNewScore) Old score: \(oldScoreA)"

		default:
			break
		}
		
		
		
		
		

		
		
		
		
		
	}
	
	// Player one selection outlet.
	@IBOutlet var playerOneCellLabel: UILabel!
	var playerOneCellText : String!

    // Player two selection outlet.
	@IBOutlet var playerTwoCellLabel: UILabel!

	
	@IBOutlet var selectWinLoseDrawSegmentedButton: UISegmentedControl!
	
	
	@IBOutlet var selectKFactorSegmentedButton: UISegmentedControl!
	
	
	
	@IBOutlet var calculateScoreButton: UIButton!
	
	@IBOutlet var dateOfMatchLabel: UILabel!
	
	
	@IBOutlet var datePicker: UIDatePicker!
	
	
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
    
    @IBAction func cancelSelectPlayerTwoSegue(segue:UIStoryboardSegue){
        let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
        if tvc.playerTwoEntity != nil {
            self.playerTwoEntity = tvc.playerTwoEntity!
        }
        self.playerInfo = tvc.playerInfo
    }
    	
    // Sets player one after selecting from list of players.
	@IBAction func unwindSetPlayerOneName(segue:UIStoryboardSegue) {
		let tvcOne = segue.sourceViewController as! PlayerOneSelectorTableViewController
		
        // Passes back the shared MOC so entities can be saved together
        self.playerInfo = tvcOne.playerInfo
	
        // Sets the selected playerOneEntity
        self.playerOneEntity = tvcOne.playerOneSelectedEntity
		
		// Updates the cell text after selection.
		self.playerOneCellLabel.text = tvcOne.playerOneSelectedEntity.name
	}
	
	@IBAction func unwindSetPlayerTwoName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
		
        
        // Passes back the shared MOC so entities can be saved together.
		self.playerInfo = tvc.playerInfo
		
        // Sets the selected playerTwoEntity from PlayerTwoSelectorTableViewController
        self.playerTwoEntity = tvc.playerTwoSelectedEntity
        
        // Update selected player cell text
		self.playerTwoCellLabel.text = tvc.playerTwoSelectedEntity.name
	
	}
	
	
	
 // MARK: TableView Delegates

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
			rows = 4
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
				
				dateOfMatchLabel.text = dateFormatter.stringFromDate(datePicker.date)
				
			print("section two pressed")
            
            
            } else {
				
			dateOfMatchLabel.text = dateFormatter.stringFromDate(datePicker.date)
			dateCellRows = dateCellRows - 1
            tableView.deleteRowsAtIndexPaths([datePickerCell!], withRowAnimation: .Top)
            print("Section two pressed to remove")
				
            datePickerCell = nil
            }
        }
        
        tableView.endUpdates()
    }
	
		
    // Need to pass over the playerInfo enity to other vc and pass the same one back between various vc's to save the same
    // managed object context.
	
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { fatalError("Segue without an identifier")}
            //let destination = segue.destinationViewController
        
        switch identifier {
        case "playerOneSegue": guard let tvc = segue.destinationViewController as? PlayerOneSelectorTableViewController else {
            fatalError("Unexpected view controller in segue 00001")
        }
            if self.playerOneEntity != nil {
                tvc.playerOneEntity = self.playerOneEntity
            }
            // Check to see if a playerInfo MOC has been created.
            if self.playerInfo != nil {
                tvc.playerInfo = self.playerInfo
            }

        case "playerTwoSegue": guard let tvc = segue.destinationViewController as? PlayerTwoSelectorTableViewController else {
            fatalError("Unexpected view controller in segue 00002")
            }
        
            if self.playerTwoEntity != nil {
                tvc.playerTwoEntity = self.playerTwoEntity
            }
            // Check to see if a playerInfo MOC has been created if so use it and pass it to tvc
            if self.playerInfo != nil {
                tvc.playerInfo = self.playerInfo
            }
        default: fatalError("Unexpected segue: \(identifier)")
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
	
	func winLoseDrawWinner(winLoseDrawControl: UISegmentedControl) -> (winningPlayer : String, losingPlayer: String) {
		
		switch winLoseDrawControl.selectedSegmentIndex
		
		{
		// Returns player one as winner and player two as losing.
		case 0 : return (playerOneEntity.name, playerTwoEntity.name)
			
		case 1 : return (playerTwoEntity.name, playerOneEntity.name)
			
		case 2 : return ("Match Tied", "Match Tied")
		
		default : return ("Error in winLoseDrawWinner", "error")
	}

	}
	//datePickerCell = NSIndexPath(forRow: 1, inSection: 2)
	
	
	
	
	
	
	
}
