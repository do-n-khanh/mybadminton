//
//  DiscoveryVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/08/30.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import FirebaseStorage
import Firebase
import FirebaseDatabase

class DiscoveryVCbackup: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ref: DatabaseReference!
    var clubArray = [Club]()
    var addressArray = [ClubAddress]()
    var photoArray = [UIImage]()
    
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadClubs()
        // Do any additional setup after loading the view.
    }

    func loadClubs() {
        
        ref = Database.database().reference()
        
        ref.child("club").observe(DataEventType.childAdded, with: { (clubSnapshot) in
            if let clubDict = clubSnapshot.value as? [String : AnyObject] {
                let name = clubDict["name"] as! String
                let explanation = clubDict["explanation"] as! String
                let courtNum = clubDict["courtNum"] as! Int
                let membershipFee = clubDict["membershipFee"] as! Int
                let visitorFee = clubDict["visitorFee"] as! Int
                let hasCarParking = clubDict["hasCarParking"] as! Bool
                let club = Club(name: name, explanation: explanation, courtNum: courtNum, membershipFee: membershipFee, visitorFee: visitorFee, hasCarParking: hasCarParking)
                self.clubArray.append(club) // Add to clubArray
                print(self.clubArray)
                
                let photoRef = Database.database().reference()
                photoRef.child("photo").child(clubSnapshot.key).child("main").observeSingleEvent(of: DataEventType.value, with: { (photoSnapshot) in
                    if let photoURL = photoSnapshot.value as? String {
                        let photoStorageRef = Storage.storage().reference(forURL: photoURL)
                        photoStorageRef.getData(maxSize: 1*1024*1024, completion: { (data, error) in
                            let pic = UIImage(data: data!)
                            self.photoArray.append(pic!)
                            print(self.photoArray)
                            self.tblView.reloadData()
                        })
                    }
                    
                })
                
                let addressRef = Database.database().reference()
                addressRef.child("address").child(clubSnapshot.key).observeSingleEvent(of: DataEventType.value, with: { (addressSnapshot) in
                    let addressDict = addressSnapshot.value as! [String: AnyObject]
                    let clubAddress = ClubAddress(postCode: addressDict["postcode"] as! String, cityName: addressDict["city"] as! String, ward: addressDict["ward"] as! String, address1: addressDict["address1"] as! String, address2: addressDict["address2"] as! String)
                    
                    self.addressArray.append(clubAddress)
                    print(self.addressArray)
                    
                    
                })
                
                
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return addressArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoveryCellIdentifier", for: indexPath) as! DiscoveryCell
        
        //cell.thumbnailImageView.image  = ""
        cell.nameLabel.text = clubArray[indexPath.row].name
        
        cell.cityLabel.text = addressArray[indexPath.row].cityName
        cell.courtNumLabel.text = String( clubArray[indexPath.row].courtNum)
        if photoArray.count > indexPath.row {
                cell.thumbnailImageView.image = photoArray[indexPath.row]
        }
        
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
