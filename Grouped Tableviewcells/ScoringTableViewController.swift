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
	
    // Stores selected player info entity.
	var playerInfo: PlayerInfo<PlayerInfoEntity>!
	var playerOneEntity: PlayerInfoEntity!
	var playerTwoEntity: PlayerInfoEntity!
    
    
    var datePickerCell : NSIndexPath?
    //datePickerCell = NSIndexPath(forRow: 1, inSection: 2)
   
    var rows = 0
    var dateCellRows = 1
    
    var dateFormatter = NSDateFormatter()
    //var datePickerIndexPath: NSIndexPath?
    
    
	
	@IBAction func cancelSelectPlayerOneSegue(segue:UIStoryboardSegue){
		print("cancelCreatePlayer function called.")
	}

    // Player one selection outlet.
	@IBOutlet var playerOneCellLabel: UILabel!
	var playerOneCellText : String!

    // Player two selection outlet.
	@IBOutlet var playerTwoCellLabel: UILabel!
	
    // Sets player one after selecting from list of players.
	@IBAction func unwindSetPlayerOneName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerOneSelectorTableViewController
        
        // Sets the selected playerOneEntity
        self.playerOneEntity = tvc.playerOneSelectedEntity
        
		self.playerOneCellLabel.text = tvc.playerOneSelectedEntity.name
        
        
		
		print(" select player one called")
	}
	
	@IBAction func unwindSetPlayerTwoName(segue:UIStoryboardSegue) {
		let tvc = segue.sourceViewController as! PlayerTwoSelectorTableViewController
        
        // Sets the selected playerTwoEntity
        self.playerTwoEntity = tvc.playerTwoSelectedEntity
        
        
		self.playerTwoCellLabel.text = tvc.playerTwoSelectedEntity.name
		print(tvc.playerTwoSelectedEntity.name)
		
		print(" select player two called")
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
            
            
            rowHeight = 200
        }
        
        
        return rowHeight
    }
	
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            rows = 2
        case 1:
            rows = 1
        case 2 :
            rows = dateCellRows
        default:
            rows = 1
        }
//        
//        if section == 0 {
//            rows = 2
//        } else if section == 1 {
//            rows = 1
//        } else if section == 2 {
//           
//           rows = dateCellRows
//            
//        }
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
