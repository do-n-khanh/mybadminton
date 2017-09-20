//
//  IrregularScheduleVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/21.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit


class IrregularScheduleVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    var numOfRow = 1
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
        let cellIdentifier = "IrregularScheduleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! IrregularScheduleCell
        if schedules.count != 0 && tableView.visibleCells.count < schedules.count {
            cell.scheduleText.text = schedules[indexPath.row].day + " " + schedules[indexPath.row].startTime
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
        numOfRow += 1
        tableView.reloadData()
        
       

    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToCreateClubTVCFromIrregularScheduleVC" {
            var clubScheduleArray : [ClubSchedule] = []
            
            for i in 0...numOfRow-1 {
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! IrregularScheduleCell
                
                let datetime = cell.scheduleText.text!.components(separatedBy: " ")
                
                clubScheduleArray.append(ClubSchedule(type: "irregular", dayInWeek: "", day: datetime[0], startTime: datetime[1], endTime: cell.endTime.text!))
                
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
            let cell = tableView.cellForRow(at: indexPath) as! IrregularScheduleCell
            if cell.scheduleText.text == nil || cell.scheduleText.text!.isEmpty || cell.endTime.text == nil || cell.endTime.text!.isEmpty   {
                pass = false
                break
            }
        }
        
        
        if pass {
            
            performSegue(withIdentifier: "backToCreateClubTVCFromIrregularScheduleVC", sender: self)
        } else {
            let alert = UIAlertController(title: "エラー", message: "すべて設定してください", preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    
    }
    
}
