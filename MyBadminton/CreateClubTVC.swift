//
//  CreateClubViewController.swift
//  MyBadminton
//
//  Created by APPLE on 2017/06/18.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import FirebaseStorage
import FirebaseAuthUI

class CreateClubTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cameraUIView: UIView!
    @IBOutlet weak var plus1UIView: UIView!
    
    
    @IBOutlet weak var plus1UIImageView: UIImageView!
    @IBOutlet weak var plus2UIImageView: UIImageView!
    @IBOutlet weak var plus3UIImageView: UIImageView!
    @IBOutlet weak var cameraUIImageView: UIImageView!
    
    
    
    
    @IBOutlet weak var clubNameTextField: UITextField!
    @IBOutlet weak var createClubBtnOutlet: UIButton!
    @IBOutlet weak var clubExplanationTV: UITextView!
    
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var courtNumLabel: UILabel!
    @IBOutlet weak var clubLevelLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var membershipFee: UITextField!
    
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var visitorFee: UITextField!
    @IBAction func tapToBackToCreateClubTVC (segue: UIStoryboardSegue) {
    
        
    }
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            club.hasCarParking = true
            
            // Change the backgroundColor property of yesButton to red
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
        } else if sender == noButton {
            club.hasCarParking = false
            
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to red
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        }
    }
    var ref: DatabaseReference!
    var selectedImage = [String: UIImage]()
    var club = Club(name: "", explanation: "", courtNum: 0, membershipFee: 0, visitorFee: 0, hasCarParking: true)
    
    
    var clubLevel = [ClubLevel(name: "初級",select: false),
                     ClubLevel(name: "中級",select: false),
                     ClubLevel(name: "上級",select: false)]
    var schedules : [ClubSchedule] = []
    
    var clubAddress : ClubAddress!
    
    
    
    let charCountLabel = UILabel()
    var currentTappedImageView: UIImageView!
    var isUpdate = false
    var clubKey : String!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        if isUpdate {
            prepareUpdate()
        }
        
        clubExplanationTV.placeholder = "クラブの紹介（任意1,000文字以内）\n紹介するために紹介するために紹介するために紹介するために紹介するために）\n\n例）ために紹介するために"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(tapGestureRecognizer:)))
       
        cameraUIImageView.isUserInteractionEnabled = true
        cameraUIImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(tapGestureRecognizer:)))
        plus1UIImageView.isUserInteractionEnabled = true
        plus1UIImageView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(tapGestureRecognizer:)))
        plus2UIImageView.isUserInteractionEnabled = true
        plus2UIImageView.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(tapGestureRecognizer:)))
        plus3UIImageView.isUserInteractionEnabled = true
        plus3UIImageView.addGestureRecognizer(tapGestureRecognizer4)
        
        handleTextField()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        addDoneBtnToKeyboard()
        addDoneBtnAndCountLabelToKeyboard1()
        
        
    }
    
    
    func expandPhotoSize(_ item: UIImageView) {
        item.contentMode = .scaleAspectFill
        item.clipsToBounds = true
        let leadingConstrain = NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal, toItem: item.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstrain.isActive = true
        
        let trailingConstrain = NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal, toItem: item.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstrain.isActive = true
        
        let topConstrain = NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: item.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstrain.isActive = true
        
        let bottomConstrain = NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: item.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        bottomConstrain.isActive = true
    
    }
    

    func prepareUpdate() {
        
        
        // Load and display photo
        let photoRef = Database.database().reference()
        photoRef.child("photo").child(clubKey).observeSingleEvent(of: .value, with: { (photoSnapshot) in
            let array:NSArray = photoSnapshot.children.allObjects as NSArray
            
            for obj in array {
                let snapshot:DataSnapshot = obj as! DataSnapshot
                let url = snapshot.value as! String
                let photoURL = URL(string: url)!
                //let photoStorageRef = Storage.storage().reference(forURL: photoURL)
                
                if snapshot.key == "main" {
                    self.cameraUIImageView.sd_setImage(with: photoURL)
                    self.expandPhotoSize(self.cameraUIImageView)
                    self.cameraLabel.text = ""
                    self.selectedImage["main"] = self.cameraUIImageView.image
                    
                }
                if snapshot.key == "sub1" {
                    self.plus1UIImageView.sd_setImage(with: photoURL)
                    self.expandPhotoSize(self.plus1UIImageView)
                    self.selectedImage["sub1"] = self.plus1UIImageView.image

                }
                if snapshot.key == "sub2" {
                    self.plus2UIImageView.sd_setImage(with: photoURL)
                    self.expandPhotoSize(self.plus2UIImageView)
                    self.selectedImage["sub2"] = self.plus2UIImageView.image
                   
                }
                if snapshot.key == "sub3" {
                    self.plus3UIImageView.sd_setImage(with: photoURL)
                    self.expandPhotoSize(self.plus3UIImageView)
                    self.selectedImage["sub3"] = self.plus3UIImageView.image
                }
                
                
            }
        })
        
        //Load and display club
        clubNameTextField.text = club.name
        clubNameTextField.textColor = UIColor.black
        clubExplanationTV.text = club.explanation
        clubExplanationTV.textColor = UIColor.black
        courtNumLabel.text = String(club.courtNum) + "面"
        courtNumLabel.textColor = UIColor.black
        membershipFee.text = String(club.membershipFee)
        membershipFee.textColor = UIColor.black
        visitorFee.text = String(club.visitorFee)
        visitorFee.textColor = UIColor.black
        if club.hasCarParking {
            // Change the backgroundColor property of yesButton to red
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        } else {
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to red
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        }
        //Display level
        clubLevelLabel.textColor = UIColor.black
        //Display address
        addressLabel.textColor = UIColor.black
        
        createClubBtnOutlet.setTitle("変更する", for: .normal)
        
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
            action: #selector(CreateClubTVC.hideKeyboard)
        )
        
        
        addButton.tintColor = UIColor.black
        
        keyboardToolbar.items = [flexibleSpace,addButton]
        
        membershipFee.inputAccessoryView = keyboardToolbar
        visitorFee.inputAccessoryView
         = keyboardToolbar
       
    }
    
    
    func addDoneBtnAndCountLabelToKeyboard1() {
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
        charCountLabel.text = " 0/40  "
        charCountLabel.sizeToFit()
        let addLabel = UIBarButtonItem.init(customView: charCountLabel)
        addButton.tintColor = UIColor.black
        keyboardToolbar.items = [addLabel, flexibleSpace,addButton]
        clubNameTextField.inputAccessoryView = keyboardToolbar
       
    }
    
   

    
    
    func hideKeyboard() {
        
        if membershipFee.isEditing {
                membershipFee.endEditing(true)
        } else
        if visitorFee.isEditing {
                visitorFee.endEditing(true)
        } else
        if clubNameTextField.isEditing {
                clubNameTextField.endEditing(true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //When unwind from NumberOfCourtTVC to CreateClubTVC, assign courtNum to courtNumLabel
        if club.courtNum != 0 {
            courtNumLabel.text = String(club.courtNum) + "面"
            
        }
        
        //When unwind from AddAddressView to CreateClubTVC, assign cityName to addressLabel
        if let _clubAddress = clubAddress {
            addressLabel.text = _clubAddress.cityName
            
        }
        //When unwind from ClubLevelView to CreateClubTVC, assign club level to clubLevelLabel.text
        var str = ""
        for eachClubLevel in clubLevel {
            if eachClubLevel.select {
                str = str + eachClubLevel.name! + "、"
            }
        }
        if str != "" {
            clubLevelLabel.text = str.substring(to: str.index(before: str.endIndex))
        }
        
        // When unwind from Schedule to CreateClubTVC, assign new value to scheduleLabel.text
        
        
        if !schedules.isEmpty {
            
            var scheduleStr = ""
            if schedules[0].type == "regular" {
                scheduleStr = "毎週"
            }
            for schedule in schedules {
                
                if schedule.type == "regular" {
                    scheduleStr += "\(schedule.dayInWeek!)・"
                }
                if schedule.type == "irregular" {
                    scheduleStr += schedule.day! + "・"
                }
                
            }
            scheduleStr = scheduleStr.substring(to: scheduleStr.index(before: scheduleStr.endIndex)) // remove last character of string
            if schedules[0].type == "regular" {
                scheduleStr += "曜日"
            }
            
            scheduleLabel.text = scheduleStr
            scheduleLabel.textColor = UIColor.black
        
        }
        
        
    }
    
    func handleTextField() {
        clubNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
  
    
    
    func textFieldDidChange(){
        charCountLabel.text = "\(clubNameTextField.text?.characters.count ?? 0)/40"
        if (clubNameTextField.text?.characters.count)! > 40 {
            let range = NSRange(location:0,length:2) // specific location. This means "range" handle 1 character at location 2
            let attributedString  = NSMutableAttributedString(string: charCountLabel.text!)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: range)
            charCountLabel.attributedText = attributedString
            
        } else
        {
            charCountLabel.textColor = UIColor.black
        }
        
        
        guard let clubName = clubNameTextField.text, !clubName.isEmpty else {
            //If does not satisfied condition
            createClubBtnOutlet.setTitleColor(UIColor.red, for: UIControlState.normal)
            createClubBtnOutlet.isEnabled = false
            return 
        }
        createClubBtnOutlet.setTitleColor(UIColor.green, for: UIControlState.normal)
        createClubBtnOutlet.isEnabled = true
    }
    
    
    func cameraTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        currentTappedImageView = tapGestureRecognizer.view as? UIImageView
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "写真を撮る", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                
                
                self.present(imagePicker,animated: true,completion: nil)
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "アルバムから選択する", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker,animated: true,completion: nil)
            }
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        // Your action
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    if currentTappedImageView == cameraUIImageView {
                        selectedImage["main"] = image
                        cameraLabel.text = ""
                    }
                    if currentTappedImageView == plus1UIImageView {
                        selectedImage["sub1"] = image
                    }
                    if currentTappedImageView == plus2UIImageView {
                        selectedImage["sub2"] = image
                    }
                    if currentTappedImageView == plus3UIImageView {
                        selectedImage["sub3"] = image
                    }
                    currentTappedImageView.image = image
                    expandPhotoSize(currentTappedImageView)
                    
                } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    if currentTappedImageView == cameraUIImageView {
                        selectedImage["main"] = image
                        cameraLabel.text = ""
                    }
                    if currentTappedImageView == plus1UIImageView {
                        selectedImage["sub1"] = image
                    }
                    if currentTappedImageView == plus2UIImageView {
                        selectedImage["sub2"] = image
                    }
                    if currentTappedImageView == plus3UIImageView {
                        selectedImage["sub3"] = image
                    }
                    currentTappedImageView.image = image
                    expandPhotoSize(currentTappedImageView)
        }
        
        
                dismiss(animated: true, completion: nil)
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNumberOfCourtView" {
            let destinationController = segue.destination as! NumberOfCourtTVC
            destinationController.clubCourtNum = club.courtNum
            
        }
        if segue.identifier == "showAddAddress" {
            let destinationController = segue.destination as! AddAddress
            destinationController.clubAddress = clubAddress
            
        }
        if segue.identifier == "showClubLevel" {
            let destinationController = segue.destination as! ClubLevelVC
            destinationController.clubLevel = clubLevel
        }
        if segue.identifier == "createClubToClubDetail" {
            let destinationController = segue.destination as! ClubDetailTVC
            destinationController.key = clubKey
            destinationController.navigationItem.hidesBackButton = true
            
        }
        if segue.identifier == "showScheduleTVC" {
            let destinationController = segue.destination as! ScheduleTVC
            destinationController.schedules = schedules
        }
    }
    
   
    @IBAction func createClubAction(_ sender: Any) {
       
        
      
        
        var message = ""
        if cameraLabel.text == "(必須)" {
            message = "写真を登録してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        } else if clubNameTextField.text == "" {
            message = "クラブ名を記入ください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        } else if clubExplanationTV.text == "" {
            message = "クラブの紹介を記入ください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        } else if courtNumLabel.text == "設定してください" {
            message = "面数を設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if clubLevelLabel.text == "設定してください" {
            message = "レベルを設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if scheduleLabel.text == "設定してください" {
            message = "練習日時を設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if addressLabel.text == "設定してください" {
            message = "練習日時を設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if membershipFee.text == "" {
            message = "会員費を設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else if visitorFee.text == "" {
            message = "ビジター費を設定してください"
            let alert = UIAlertController(title: "エラー", message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (UIAlertAction) in}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            
            //Prepare data and upload to firebase
            club.name = clubNameTextField.text!
            club.explanation = clubExplanationTV.text!
            club.membershipFee = Int(membershipFee.text!)!
            club.visitorFee = Int(visitorFee.text!)!
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            var clubRef = ref.child("club").childByAutoId()
            if isUpdate {
                clubRef = ref.child("club").child(clubKey)
            }
            self.clubKey = clubRef.key
            clubRef.setValue(["name":club.name,"explanation":club.explanation,"courtNum":club.courtNum,"membershipFee":club.membershipFee,"visitorFee":club.visitorFee,"hasCarParking":club.hasCarParking])
            
            let levelRef = ref.child("level").child(clubRef.key)
            let clubLevelDict: [String: Bool] = [clubLevel[0].name:clubLevel[0].select,clubLevel[1].name:clubLevel[1].select,clubLevel[2].name:clubLevel[2].select]
            levelRef.setValue(clubLevelDict)

            
            let scheduleRefs = ref.child("schedule").child(clubRef.key)
            //Remove all old schedules, then add new schedule
            if isUpdate {
                
                scheduleRefs.removeValue()
                
            }
            for eachSchedule in schedules {
                let scheduleRef = scheduleRefs.childByAutoId()
                let scheduleDict = ["type" : eachSchedule.type,"day":eachSchedule.day,"startTime":eachSchedule.startTime,"endTime": eachSchedule.endTime,"dayInWeek":eachSchedule.dayInWeek]
                scheduleRef.setValue(scheduleDict)
                
            }
            
            let addressRef = ref.child("address").child(clubRef.key)
            let addressDict = ["postcode":clubAddress.postCode,"city":clubAddress.cityName,"ward":clubAddress.ward,"address1":clubAddress.address1,"address2":clubAddress.address2]
            addressRef.setValue(addressDict)
            
            let managerRef = ref.child("manager").child(clubRef.key).child("createdBy")
            managerRef.setValue(Auth.auth().currentUser!.uid)
            
            
            
            
            let storageRef = Storage.storage().reference(forURL: "gs://mybadminton-69451.appspot.com").child("club_photo").child(clubRef.key)
            let fetchGroup = DispatchGroup()
            for p in selectedImage {
                let imageData = UIImageJPEGRepresentation(p.value, 0.25)
                let storageImgRef = storageRef.child(p.key + ".jpg")
                fetchGroup.enter()
                storageImgRef.putData(imageData!, metadata: nil) { (metadata, error) in
                    if error != nil {
                        print(error!)
                        fetchGroup.leave()
                        return
                    }
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    var photoRef: DatabaseReference!
                    if p.key == "main" {
                            photoRef = ref.child("photo").child(clubRef.key).child("main")
                    }
                    if p.key == "sub1" {
                        photoRef = ref.child("photo").child(clubRef.key).child("sub1")
                    }
                    if p.key == "sub2" {
                        photoRef = ref.child("photo").child(clubRef.key).child("sub2")
                    }
                    if p.key == "sub3" {
                        photoRef = ref.child("photo").child(clubRef.key).child("sub3")
                    }
                    
                    photoRef.setValue(downloadURL)
                    fetchGroup.leave()
                    print("Upload photo: \(p.key)")
                    
                    
                }
                
            }
            message = "しばらくお待ちください！"
            let alert = UIAlertController(title: "クラブの情報をアップロードしています。", message: message, preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            
            fetchGroup.notify(queue: DispatchQueue.main) {
                alert.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "createClubToClubDetail", sender: self)
                
            }
            
        }
        
    }
    
    

}
