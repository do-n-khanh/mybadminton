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
            destinationController.selectedCityName = cityNameLabel.text!
        }
        
        if segue.identifier == "backToCreateClubTVCFromAddAddress" {
            //Todo: CHECK VALID FIELDs
            clubAddress = ClubAddress(postCode: postCodeTextField.text!, cityName: cityNameLabel.text!, ward: wardTextField.text!, address1: address1TextField.text!, address2: address2TextField.text!)
            let destinationController = segue.destination as! CreateClubTVC
            destinationController.clubAddress = clubAddress
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
