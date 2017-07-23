//
//  RegularScheduleVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/21.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit


class RegularScheduleVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var numOfRow = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
        self.title = "スケジュール登録"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let barBtnAddRow = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewRow(_:)))
        self.navigationItem .setRightBarButton(barBtnAddRow, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RegularScheduleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RegularScheduleCell
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
           numOfRow -= 1
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
           
        tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       // let rowContent = self.arrPlayerNumber[sourceIndexPath.row]
      //  self.arrPlayerNumber.remove(at: sourceIndexPath.row)
     //   self.arrPlayerNumber.insert(rowContent, at: destinationIndexPath.row)
    }
    
    func insertNewRow(_ sender: UIBarButtonItem) {
        if numOfRow < 7 {
            numOfRow += 1
            tableView.reloadData()
            
        }
        
       

    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    
}
