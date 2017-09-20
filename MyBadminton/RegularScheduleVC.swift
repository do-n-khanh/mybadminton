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
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    var numOfRow = 1
    var allCellsText = [String]()
    var schedules : [ClubSchedule] = []
    
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
        
        if schedules.count != 0 && tableView.visibleCells.count < schedules.count {
            cell.dayInWeek.text = schedules[indexPath.row].dayInWeek
            cell.startTime.text = schedules[indexPath.row].startTime
            cell.endTime.text = schedules[indexPath.row].endTime
        }
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete && numOfRow > 1)  {
            
           numOfRow -= 1
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
           
        tableView.reloadData()
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCreateClubTVCFromRegularScheduleVC" {
            var clubScheduleArray : [ClubSchedule] = []
            
            for i in 0...numOfRow-1 {
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! RegularScheduleCell
                clubScheduleArray.append(ClubSchedule(type: "regular", dayInWeek: cell.dayInWeek.text!, day: "", startTime: cell.startTime.text!, endTime: cell.endTime.text!))
                
            }
            
            
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.schedules = clubScheduleArray
            destinationController.scheduleLabel.text = "設定済み"
            destinationController.scheduleLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        //Check if all fields are filled
        var pass = true
        for i in 0...numOfRow-1 {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! RegularScheduleCell
            if cell.dayInWeek.text == nil || cell.dayInWeek.text!.isEmpty || cell.startTime.text == nil || cell.startTime.text!.isEmpty || cell.endTime.text == nil || cell.endTime.text!.isEmpty   {
                pass = false
                break
            }
        }
        
        
        if pass {
            
                performSegue(withIdentifier: "backToCreateClubTVCFromRegularScheduleVC", sender: self)
        } else {
            let alert = UIAlertController(title: "エラー", message: "すべて設定してください", preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}
