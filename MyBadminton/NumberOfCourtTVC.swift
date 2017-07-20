//
//  NumberOfCourtTVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/17.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class NumberOfCourtTVC: UITableViewController {
    var clubCourtNum: String!
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
        if clubCourtNum != nil {
                cell.accessoryType = court[indexPath.row] == clubCourtNum ? .checkmark : .none
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCreateClubViewFromNumberOfCourtTVC" {
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.clubCourtNum = court[self.tableView.indexPathForSelectedRow!.row]
            
        }
    }

}
