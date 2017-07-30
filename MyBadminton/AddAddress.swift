//
//  AddAddress.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/18.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class AddAddress: UITableViewController {

    @IBOutlet weak var postCodeTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var wardTextField: UITextField!

    @IBOutlet weak var address1TextField: UITextField!
    
    @IBOutlet weak var address2TextField: UITextField!
    
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func cityNameCellClicked (segue: UIStoryboardSegue) {
        
        
    }
    var clubAddress : ClubAddress!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "住所"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        addDoneBtnToKeyboard()
        
    }
    func addDoneBtnToKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.lightGray
        //creating flexibleSpace
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(hideKeyboard)
        )
        
        
        addButton.tintColor = UIColor.black
        
        keyboardToolbar.items = [flexibleSpace,addButton]
        
        postCodeTextField.inputAccessoryView = keyboardToolbar
        wardTextField.inputAccessoryView = keyboardToolbar
        address1TextField.inputAccessoryView = keyboardToolbar
        address2TextField.inputAccessoryView = keyboardToolbar
        
    }
    
    func hideKeyboard() {
        
        if postCodeTextField.isEditing {
            postCodeTextField.endEditing(true)
        }
        if wardTextField.isEditing {
            wardTextField.endEditing(true)
        }
        if address1TextField.isEditing {
            address1TextField.endEditing(true)
        }
        if address2TextField.isEditing {
            address2TextField.endEditing(true)
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        if let _clubAddress = clubAddress {
            postCodeTextField.text = _clubAddress.postCode
            cityNameLabel.text = _clubAddress.cityName
            wardTextField.text = _clubAddress.ward
            address1TextField.text = _clubAddress.address1
            address2TextField.text = _clubAddress.address2
            cityNameLabel.textColor = UIColor.black
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityName" {
            let destinationController = segue.destination as! CityNameTVC
            
            clubAddress = ClubAddress(postCode: postCodeTextField.text!, cityName: cityNameLabel.text!, ward: wardTextField.text!, address1: address1TextField.text!, address2: address2TextField.text!)
            destinationController.clubAddress = clubAddress
        }
        
        if segue.identifier == "backToCreateClubTVCFromAddAddress" {
            //Todo: CHECK VALID FIELDs
            clubAddress = ClubAddress(postCode: postCodeTextField.text!, cityName: cityNameLabel.text!, ward: wardTextField.text!, address1: address1TextField.text!, address2: address2TextField.text!)
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.clubAddress = clubAddress
            destinationController.addressLabel.textColor = UIColor.black
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
