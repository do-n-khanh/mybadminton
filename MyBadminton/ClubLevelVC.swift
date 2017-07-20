//
//  ClubLevelVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/20.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class ClubLevelVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    var clubLevel : [ClubLevel] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "レベル"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubLevel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clubLevelreuseIdentifier", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = clubLevel[indexPath.row].name
        if clubLevel[indexPath.row].select {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            //            cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark
            
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                clubLevel[indexPath.row].select = false
            } else {
                cell.accessoryType = .checkmark
                clubLevel[indexPath.row].select = true
            }
            
        }
    }
       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCreateClubViewFromClubLevelVC" {
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.clubLevel = clubLevel
            
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
