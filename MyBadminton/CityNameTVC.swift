//
//  CityNameTVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/18.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class CityNameTVC: UITableViewController {
    let cityName = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    var selectedCityName = ""
    var clubAddress : ClubAddress!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "都道府県"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = cityName[indexPath.row]
        
        if let _clubAddress = clubAddress {
            cell.accessoryType = cityName[indexPath.row] == _clubAddress.cityName ? .checkmark : .none
            
        }
        
    
        
        return cell
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToAddAddress" {
            let destinationController = segue.destination as! AddAddress
            
            if let _clubaddress = clubAddress {
                clubAddress = ClubAddress(postCode: _clubaddress.postCode, cityName: cityName[self.tableView.indexPathForSelectedRow!.row], ward: _clubaddress.ward, address1: _clubaddress.address1, address2: _clubaddress.address2)
                
            } else {
                clubAddress = ClubAddress(postCode: "", cityName: cityName[self.tableView.indexPathForSelectedRow!.row], ward: "", address1: "", address2: "")
                
            }
            destinationController.clubAddress = clubAddress
            
            destinationController.cityNameLabel.textColor = UIColor.black
        //    destinationController.wardTextField.edd
            
        }
    }

    

}