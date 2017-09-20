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

class DiscoveryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ref: DatabaseReference!
    var clubArray = [Club]()
    var addressArray = [ClubAddress]()
    var photoArray = [UIImage]()
    var levelArray = [String]()
    var keyArray = [String]()
    var scheduleArray = [Array<ClubSchedule>]()
    var photoURLArray = [URL]()
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadClubs()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        
        
    }

    
    func loadClubs() {
        
        
        
        
        let photoRef = Database.database().reference()
        
        photoRef.child("photo").observe(DataEventType.childAdded, with: { (photoSnapshot) in
            if let photoDict = photoSnapshot.value as? [String : AnyObject] {
                
                var thumbnailURL : String!
                if let main = photoDict["main"] as? String {
                    thumbnailURL = main
                } else if let main = photoDict["sub1"] as? String {
                    thumbnailURL = main
                } else if let main = photoDict["sub2"] as? String {
                    thumbnailURL = main
                } else if let main = photoDict["sub3"] as? String {
                    thumbnailURL = main
                }
                
                
                
                
                self.photoURLArray.append(URL(string: thumbnailURL )!)
                let addressRef = Database.database().reference()
                addressRef.child("address").child(photoSnapshot.key).observeSingleEvent(of: DataEventType.value, with: { (addressSnapshot) in
                    let addressDict = addressSnapshot.value as! [String: AnyObject]
                    let clubAddress = ClubAddress(postCode: addressDict["postcode"] as! String, cityName: addressDict["city"] as! String, ward: addressDict["ward"] as! String, address1: addressDict["address1"] as! String, address2: addressDict["address2"] as! String)
                    
                    self.addressArray.append(clubAddress)
                })
                
                let levelRef = Database.database().reference()
                levelRef.child("level").child(photoSnapshot.key).observeSingleEvent(of: DataEventType.value, with: { (levelSnapshot) in
                    let levelDict = levelSnapshot.value as! [String: AnyObject]
                    var clubLevelStr = ""
                    if levelDict["初級"] as! Bool {
                        clubLevelStr = clubLevelStr + "初級、"
                    }
                    if levelDict["中級"] as! Bool {
                        clubLevelStr = clubLevelStr + "中級、"
                    }
                    if levelDict["上級"] as! Bool {
                        clubLevelStr = clubLevelStr + "上級、"
                    }
                    clubLevelStr = clubLevelStr.substring(to: clubLevelStr.index(before: clubLevelStr.endIndex))
                    
                    self.levelArray.append(clubLevelStr)
                    
                })
                
                let scheduleRef = Database.database().reference()
                scheduleRef.child("schedule").child(photoSnapshot.key).observeSingleEvent(of: DataEventType.value, with: { (scheduleSnapshot) in
                    let array:NSArray = scheduleSnapshot.children.allObjects as NSArray
                    var schedules = [ClubSchedule]()
                    for obj in array {
                        let snapshot:DataSnapshot = obj as! DataSnapshot
                        if let childSnapshot = snapshot.value as? [String : AnyObject]
                        {
                            let schedule = ClubSchedule(type: childSnapshot["type"] as! String,
                                                        dayInWeek: childSnapshot["dayInWeek"] as! String,
                                                        day: childSnapshot["day"] as! String,
                                                        startTime: childSnapshot["startTime"] as! String,
                                                        endTime: childSnapshot["endTime"] as! String)
                            schedules.append(schedule)
                            
                        }
                    }
                    self.scheduleArray.append(schedules)
                    
                    
                })
                
                
                let clubRef = Database.database().reference()
                clubRef.child("club").child(photoSnapshot.key).observeSingleEvent(of: DataEventType.value, with: { (clubSnapshot) in
                    if let clubDict = clubSnapshot.value as? [String : AnyObject] {
                        let name = clubDict["name"] as! String
                        let explanation = clubDict["explanation"] as! String
                        let courtNum = clubDict["courtNum"] as! Int
                        let membershipFee = clubDict["membershipFee"] as! Int
                        let visitorFee = clubDict["visitorFee"] as! Int
                        let hasCarParking = clubDict["hasCarParking"] as! Bool
                        let club = Club(name: name, explanation: explanation, courtNum: courtNum, membershipFee: membershipFee, visitorFee: visitorFee, hasCarParking: hasCarParking)
                        self.clubArray.append(club) // Add to clubArray
                        self.keyArray.append(photoSnapshot.key)
                        self.tblView.reloadData()
                    }
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
        
        return clubArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoveryCellIdentifier", for: indexPath) as! DiscoveryCell
        
        //cell.thumbnailImageView.image  = ""
        cell.nameLabel.text = clubArray[indexPath.row].name
        
        cell.cityLabel.text = addressArray[indexPath.row].cityName
        cell.courtNumLabel.text = levelArray[indexPath.row] //String( clubArray[indexPath.row].courtNum)
        
        
        
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        cell.thumbnailImageView.sd_setShowActivityIndicatorView(true)
        cell.thumbnailImageView.sd_setIndicatorStyle(.gray)
        cell.thumbnailImageView.sd_setImage(with: photoURLArray[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showClubDetail" {
            if let indexPath = tblView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ClubDetailTVC
                destinationController.key = keyArray[indexPath.row]
                
                
            }
        }
            
        
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
