//
//  RegularScheduleCell.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/22.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class RegularScheduleCell: UITableViewCell,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var dayInWeek: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    
    let timePicker = UIDatePicker()
    let dayPicker = UIPickerView()
    let daysInWeek = ["月","火","水","木","金","土","日"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dayPicker.dataSource = self
        dayPicker.delegate = self
        createTimePicker()
        createDayPicker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysInWeek.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysInWeek[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dayInWeek.text = daysInWeek[row]
    }
    func createDayPicker() {
        let dayPickerToolbar = UIToolbar()
        dayPickerToolbar.sizeToFit()
        dayPickerToolbar.isTranslucent = true
        dayPickerToolbar.barTintColor = UIColor.lightGray
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(addDay)
        )
        
        doneButton.tintColor = UIColor.black
        
        dayPickerToolbar.items = [flexibleSpace,doneButton]
        dayInWeek.inputAccessoryView = dayPickerToolbar
        //setup dayPicker
        dayInWeek.inputView = dayPicker
        
    }
    func addDay() {
        
        dayInWeek.text = daysInWeek[dayPicker.selectedRow(inComponent: 0)]
        dayInWeek.endEditing(true)
        
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
        
        startTime.inputAccessoryView = timePickerToolbar
        timePicker.datePickerMode = .time
        timePicker.minuteInterval = 10
        
        startTime.inputView = timePicker
        endTime.inputAccessoryView = timePickerToolbar
        endTime.inputView = timePicker
        
    }
    
    
    func addTime() {
        
        //Format time
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ja_JP")
        timeFormatter.timeStyle = .short
        if startTime.isEditing {
            startTime.text = timeFormatter.string(from: timePicker.date)
            
            startTime.endEditing(true)
        }
        
        if endTime.isEditing {
            endTime.text = timeFormatter.string(from: timePicker.date)
            
            endTime.endEditing(true)
        }
        
        
    }

}
