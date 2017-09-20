//
//  ClubDetailTVC.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/09/04.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import FirebaseStorage
import Firebase
import FirebaseDatabase
import FirebaseStorageUI



class ClubDetailTVC: UITableViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var clubExplanationLabel: UILabel!
    
    @IBOutlet weak var creatorAvatar: UIImageView!
    @IBOutlet weak var courtNumLabel: UILabel!
    
    
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var membershipFeeLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var hasParkingCarLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var visitorFeeLabel: UILabel!
    
    @IBOutlet weak var scheduleLabel: UILabel!
    var key: String!
    var club: Club!
    var level : String!
    var address: ClubAddress!
    var schedules = [ClubSchedule]()
    var photoArray = [UIImage]()
    //var photoStorageRefArray = [StorageReference]()
    var photoURLArray = [URL]()
    var userIdArray = [String]()
    
    var clubLevel = [ClubLevel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadManager()
        loadClub()
        loadPhoto()
        loadAddress()
        loadSchedule()
        loadLevel()
        
        
        
        

        
        
        
    }
    

   
    func addEditDeleteBtn() {
        
        
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editClub))
        
        
        let delete = UIBarButtonItem(title: "削除", style: .plain, target: self, action: #selector(deleteClub))
        
        navigationItem.rightBarButtonItems = [edit, delete]
        
        
    }

    func editClub() {
        performSegue(withIdentifier: "clubDetailToEditClub", sender: self)
    }
    func deleteClub() {
        
        let message = "本当にクラブを削除しますか。"
        let alert = UIAlertController(title: "確認", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
        
        
        let ok = UIAlertAction(title: "削除", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            let addressRef = Database.database().reference().child("address").child(self.key)
            addressRef.removeValue()
            
            let clubRef = Database.database().reference().child("club").child(self.key)
            clubRef.removeValue()
            
            let levelRef = Database.database().reference().child("level").child(self.key)
            levelRef.removeValue()
            
            let managerRef = Database.database().reference().child("manager").child(self.key)
            managerRef.removeValue()
            
            let photoRef = Database.database().reference().child("photo").child(self.key)
            
            photoRef.removeValue()
            
            let storageRef_main = Storage.storage().reference(forURL: "gs://mybadminton-69451.appspot.com").child("club_photo").child(self.key).child("main.jpg")
            // Delete the file
            storageRef_main.delete { error in
                if error != nil {
                   // print(error!)
                } else {
                    // File deleted successfully
                }
            }
            
            let storageRef_sub1 = Storage.storage().reference(forURL: "gs://mybadminton-69451.appspot.com").child("club_photo").child(self.key).child("sub1.jpg")
            // Delete the file
            storageRef_sub1.delete { error in
                if error != nil {
                    //print(error!)
                } else {
                    // File deleted successfully
                }
            }
            
            let storageRef_sub2 = Storage.storage().reference(forURL: "gs://mybadminton-69451.appspot.com").child("club_photo").child(self.key).child("sub2.jpg")
            // Delete the file
            storageRef_sub2.delete { error in
                if error != nil {
                   // print(error!)
                } else {
                    // File deleted successfully
                }
            }
            
            let storageRef_sub3 = Storage.storage().reference(forURL: "gs://mybadminton-69451.appspot.com").child("club_photo").child(self.key).child("sub3.jpg")
            // Delete the file
            storageRef_sub3.delete { error in
                if error != nil {
                  //  print(error!)
                } else {
                    // File deleted successfully
                }
            }
            
            
            
            let scheduleRef = Database.database().reference().child("schedule").child(self.key)
            scheduleRef.removeValue()
            
            self.performSegue(withIdentifier: "clubDetailToDiscovery", sender: self)
        
        }
        
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    func loadManager() {
        let managerRef = Database.database().reference()
        managerRef.child("manager").child(key).observeSingleEvent(of: DataEventType.value, with: { (managerSnapshot) in
            let array:NSArray = managerSnapshot.children.allObjects as NSArray
            

            for obj in array {
                let snapshot:DataSnapshot = obj as! DataSnapshot
                
                //Load and display info of creator
                if snapshot.key == "createdBy" {
                    let creatorId = snapshot.value as! String
                    let creatorRef = Database.database().reference()
                    creatorRef.child("users").child(creatorId).observeSingleEvent(of: DataEventType.value, with: { (creatorSnapshot) in
                        if let creatorDict = creatorSnapshot.value as? [String : AnyObject] {
                            let creatorName = creatorDict["displayName"] as! String
                            let creatorAvatarUrl = creatorDict["photoURL"] as! String
                            self.creatorNameLabel.text = creatorName
                            self.creatorAvatar.sd_setImage(with: URL(string: creatorAvatarUrl))
                            self.creatorAvatar.layer.cornerRadius = 30.0
                        }
                    })
                    
                }
                self.userIdArray.append(snapshot.value as! String)
                
                            }
            
            if let currentUserId = Auth.auth().currentUser?.uid {
                
                if self.userIdArray.contains(currentUserId) { //currentUserId == snapshot.value as! String {
                    self.addEditDeleteBtn()
                    
                }
            }

            
            
        })
        
        
    }

    
    
    func loadClub() {
        
        let clubRef = Database.database().reference()
        clubRef.child("club").child(key).observeSingleEvent(of: DataEventType.value, with: { (clubSnapshot) in
            if let clubDict = clubSnapshot.value as? [String : AnyObject] {
                let name = clubDict["name"] as! String
                let explanation = clubDict["explanation"] as! String
                let courtNum = clubDict["courtNum"] as! Int
                let membershipFee = clubDict["membershipFee"] as! Int
                let visitorFee = clubDict["visitorFee"] as! Int
                let hasCarParking = clubDict["hasCarParking"] as! Bool
                
                self.club = Club(name: name, explanation: explanation, courtNum: courtNum, membershipFee: membershipFee, visitorFee: visitorFee, hasCarParking: hasCarParking)
                self.title = name
                self.clubExplanationLabel.text = explanation
                self.clubExplanationLabel.numberOfLines = 0
                self.courtNumLabel.text = String(courtNum)
                self.membershipFeeLabel.text = String(membershipFee) + "円"
                self.visitorFeeLabel.text = String(visitorFee) + "円"
                self.hasParkingCarLabel.text = hasCarParking ? "あり" : "なし"
                
            }
        })
        
        
        
    }
    
    func loadLevel() {
        let levelRef = Database.database().reference()
        levelRef.child("level").child(key).observeSingleEvent(of: DataEventType.value, with: { (levelSnapshot) in
            let levelDict = levelSnapshot.value as! [String: AnyObject]
            var clubLevelStr = ""
            if levelDict["初級"] as! Bool {
                clubLevelStr = clubLevelStr + "初級、"
                self.clubLevel.append(ClubLevel(name: "初級", select: true))
            } else {
                self.clubLevel.append(ClubLevel(name: "初級", select: false))
            }
            
            if levelDict["中級"] as! Bool {
                clubLevelStr = clubLevelStr + "中級、"
                self.clubLevel.append(ClubLevel(name: "中級", select: true))
            } else {
                self.clubLevel.append(ClubLevel(name: "中級", select: false))
            }
            if levelDict["上級"] as! Bool {
                clubLevelStr = clubLevelStr + "上級、"
                self.clubLevel.append(ClubLevel(name: "上級", select: true))
            } else {
                self.clubLevel.append(ClubLevel(name: "上級", select: false))
            }
            clubLevelStr = clubLevelStr.substring(to: clubLevelStr.index(before: clubLevelStr.endIndex))
            
            self.levelLabel.text = clubLevelStr
            
        })
    }
    
    func loadSchedule() {
        let scheduleRef = Database.database().reference()
        scheduleRef.child("schedule").child(key).observeSingleEvent(of: DataEventType.value, with: { (scheduleSnapshot) in
            let array:NSArray = scheduleSnapshot.children.allObjects as NSArray
            //var schedules = [ClubSchedule]()
            
            for obj in array {
                let snapshot:DataSnapshot = obj as! DataSnapshot
                if let childSnapshot = snapshot.value as? [String : AnyObject]
                {
                    let schedule = ClubSchedule(type: childSnapshot["type"] as! String,
                                                dayInWeek: childSnapshot["dayInWeek"] as! String,
                                                day: childSnapshot["day"] as! String,
                                                startTime: childSnapshot["startTime"] as! String,
                                                endTime: childSnapshot["endTime"] as! String)
                    self.schedules.append(schedule)
                    
                }
            }

            var scheduleStr = ""
            for schedule in self.schedules {
                
                if schedule.type == "regular" {
                    scheduleStr += "毎週\(schedule.dayInWeek!)曜日\(schedule.startTime!)〜\(schedule.endTime!)\n"
                }
                if schedule.type == "irregular" {
                    scheduleStr += schedule.day! + " " + schedule.startTime! + "〜" + schedule.endTime! + "\n"
                }
                
            }
            scheduleStr = scheduleStr.substring(to: scheduleStr.index(before: scheduleStr.endIndex))
            self.scheduleLabel.text = scheduleStr
            self.scheduleLabel.numberOfLines = 0
            self.tableView.reloadData()
            
        })
        

    }
    
    
    func loadAddress() {
        let addressRef = Database.database().reference()
        addressRef.child("address").child(key).observeSingleEvent(of: DataEventType.value, with: { (addressSnapshot) in
            let addressDict = addressSnapshot.value as! [String: AnyObject]
            self.address = ClubAddress(postCode: addressDict["postcode"] as! String, cityName: addressDict["city"] as! String, ward: addressDict["ward"] as! String, address1: addressDict["address1"] as! String, address2: addressDict["address2"] as! String)
            
            self.addressLabel.text = "〒" + self.address.postCode + " " + self.address.cityName + self.address.ward + self.address.address1 + self.address.address2
            self.addressLabel.numberOfLines = 0
            
            
        })
    }

   
    
    func loadPhoto() {
        let photoRef = Database.database().reference()
        
        
        photoRef.child("photo").child(key).observeSingleEvent(of: .value, with: { (photoSnapshot) in
            let array:NSArray = photoSnapshot.children.allObjects as NSArray
            for obj in array {
                let snapshot:DataSnapshot = obj as! DataSnapshot
                let photoURL = snapshot.value as! String
                //let photoStorageRef = Storage.storage().reference(forURL: photoURL)
                
                self.photoURLArray.append(URL(string: photoURL)!)
                //self.photoStorageRefArray.append(photoStorageRef)
                self.photoCollection.reloadData()
                
            }
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Remove header of 1st section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let headerHeight: CGFloat
        
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 21
        }
        
        return headerHeight
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return photoArray.count
        return photoURLArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCellIdentifier", for: indexPath) as! photoCollectionViewCell
        
        //collectionCell.photo.image = photoArray[indexPath.row]
        
        collectionCell.photo.sd_setShowActivityIndicatorView(true)
        collectionCell.photo.sd_setIndicatorStyle(.gray)
        
        collectionCell.photo.sd_setImage(with: photoURLArray[indexPath.row])
        
        
        
        
        
        return collectionCell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->CGSize {
        
        
//        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = tableView.frame.width
        
        return CGSize(width: screenWidth, height: 299.5);
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 300
            
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            return 80
        }
        
        if indexPath.section == 3 && indexPath.row == 0 {
            return 80
        }
        else {
                return UITableViewAutomaticDimension
        }
        
    }
   
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clubDetailToEditClub" {
            let destinationController = segue.destination as! CreateClubTVC
            
            destinationController.isUpdate = true
            destinationController.clubKey = key
            
            
            destinationController.club = club
            destinationController.clubLevel = clubLevel
            destinationController.clubAddress = address
            destinationController.schedules = schedules
            
        }
        if segue.identifier == "clubDetailToDiscovery" {
            let destinationController = segue.destination as! DiscoveryVC
            destinationController.navigationItem.hidesBackButton = true
        }
    }

}
