//
//  PlayerDetailTableTableViewController.swift
//  Grouped Tableviewcells
//
//  Created by Chris Stromberg on 8/8/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

enum PlayerInfoSection: Int {
    case Name, ClubID, Score, Wins, Losses, Draws, LatestResult, Email
    static let allValues = [Name, ClubID, Score, Wins, Losses, Draws, LatestResult, Email]
}

class PlayerDetailTableTableViewController: UITableViewController {
    
    var player: PlayerInfo<PlayerInfoEntity>!
    var playerEnity: PlayerInfoEntity!

    @IBOutlet weak var playerNameLabel: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Code to instatiate a playerInfo enity matching by the selected table in previous segue controller.
         
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
        
        // Return the number of rows in the section.
        
        var rowCount = 0
        
        if section == 0 {
            rowCount = PlayerInfoSection.allValues.count
        }
        else if section == 1
        {
            rowCount = 1
        }
        return rowCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Generic Cell add identifier later
        var cell: UITableViewCell!
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
                
                // indexPath row = to 0
            case PlayerInfoSection.Name.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath)
                cell.textLabel?.text = self.playerEnity.name
                
                // indexPath row = to 1
            case PlayerInfoSection.ClubID.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("ClubIDCell", forIndexPath: indexPath)
                cell.textLabel?.text = self.playerEnity.clubID
                
                // indexPath row = to 2
            case PlayerInfoSection.Score.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("ScoreCell", forIndexPath: indexPath)
                cell.textLabel?.text = ("\(self.playerEnity.score)")
                
                
            // indexPath row = to 3
            case PlayerInfoSection.Wins.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("WinCell", forIndexPath: indexPath)
                cell.textLabel?.text = ("\(self.playerEnity.wins)")
                
               
            // indexPath row = to 4
            case PlayerInfoSection.Losses.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("LossesCell", forIndexPath: indexPath)
                cell.textLabel?.text = ("\(self.playerEnity.losses)")
                
            // indexPath row = to 5
            case PlayerInfoSection.Draws.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("DrawsCell", forIndexPath: indexPath)
                cell.textLabel?.text = ("\(self.playerEnity.draws)")
                
            // indexPath row = to 6
            case PlayerInfoSection.LatestResult.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("LatestResultCell", forIndexPath: indexPath)
                //cell.textLabel?.text = self.playerEnity.latestResult
                cell.textLabel?.text = "No player results"
            // indexPath row = to 7
            case PlayerInfoSection.Email.rawValue:
                cell = tableView.dequeueReusableCellWithIdentifier("EmailCell", forIndexPath: indexPath)
                cell.textLabel?.text = self.playerEnity.email
                print("email :\(self.playerEnity.email)")
            default:
                cell.textLabel?.text = "This is not working"
                break
            }
            
            
        }
        
        // Configure the cell...

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

}
