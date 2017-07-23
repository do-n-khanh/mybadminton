//
//  IrregularScheduleCell.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/22.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class IrregularScheduleCell: UITableViewCell{
    
    
    @IBOutlet weak var scheduleText: UITextField!
    @IBOutlet weak var endTime: UITextField!
    let schedulePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        createSchedulePicker()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        createTimePicker()
    }
    
    
        func createSchedulePicker() {
        let schedulePickerToolbar = UIToolbar()
        schedulePickerToolbar.sizeToFit()
        schedulePickerToolbar.isTranslucent = true
        schedulePickerToolbar.barTintColor = UIColor.lightGray
        //creating flexibleSpace
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(addSchedule)
        )
        
        doneButton.tintColor = UIColor.black
        
        schedulePickerToolbar.items = [flexibleSpace,doneButton]
        
        scheduleText.inputAccessoryView = schedulePickerToolbar
        schedulePicker.datePickerMode = .dateAndTime
       
        schedulePicker.minuteInterval = 10
        scheduleText.inputView = schedulePicker
       
    }
    
    
    func addSchedule() {
        
        //Format schedule
        let scheduleFormatter = DateFormatter()
        scheduleFormatter.dateStyle = .short
        scheduleFormatter.timeStyle = .short
        scheduleText.text = scheduleFormatter.string(from: schedulePicker.date)
        //scheduleText.text = "\(schedulePicker.date)"
        scheduleText.endEditing(true)

    }
    func createTimePicker() {
        let timePickerToolbar = UIToolbar()
        timePickerToolbar.sizeToFit()
        timePickerToolbar.isTranslucent = true
        timePickerToolbar.barTintColor = UIColor.lightGray
        //creating flexibleSpace
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(addTime)
        )
        
        doneButton.tintColor = UIColor.black
        
        timePickerToolbar.items = [flexibleSpace,doneButton]
        
        
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 10
        
        
        endTime.inputAccessoryView = timePickerToolbar
        endTime.inputView = timePicker
        
    }
    
    
    func addTime() {
        
        //Format time
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        endTime.text = timeFormatter.string(from: timePicker.date)
        
        endTime.endEditing(true)
        
        
    }

}
