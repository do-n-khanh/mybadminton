//
//  NumberOfCourtTVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/17.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class NumberOfCourtTVC: UITableViewController {
    var currentNumberOfCourt: String!
    let court = ["1面","2面","3面","4面","5面","6面"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //tableView.backgroundColor = UIColor(red: 240.0/250.0, green: 240.0/255.0, blue: 240.0/250.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //UINavigationBar.appearance().title
        self.title = "面数"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("Row is slect \(indexPath.row)")
//        
//    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return court.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courtRowIdentifier", for: indexPath)

        cell.textLabel?.text = court[indexPath.row]
        cell.detailTextLabel?.text = ""
        
        
        if indexPath.row == court.index(of: currentNumberOfCourt) {
                cell.accessoryType = .checkmark
        }
        else {
            
        }
        
        return cell
    }
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if identifier == "backToCreateClubView" {
//            let destinationController = segue.destination as! CreateClubTVC
//            destinationController.courtDetailLabel.text = "Test"
//            //self.tableView.indexPathForSelectedRows
//        }
//        
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCreateClubView" {
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.courtDetailLabel.text = court[self.tableView.indexPathForSelectedRow!.row]
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
