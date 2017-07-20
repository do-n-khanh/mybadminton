//
//  CreateClubViewController.swift
//  MyBadminton
//
//  Created by APPLE on 2017/06/18.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class CreateClubTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var cameraUIView: UIView!
    @IBOutlet weak var cameraUIImageView: UIImageView!
    @IBOutlet weak var clubNameTextField: UITextField!
    @IBOutlet weak var createClubBtnOutlet: UIButton!
    @IBOutlet weak var clubExplanationTV: UITextView!
    
    @IBOutlet weak var courtDetailLabel: UILabel!
    @IBOutlet weak var clubLevelLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func tapToBackToCreateClubTVC (segue: UIStoryboardSegue) {
    
        
    }
    var clubCourtNum : String!
    var clubAddress : ClubAddress!
    
    var clubLevel = [ClubLevel(name: "初級",select: false),
                     ClubLevel(name: "中級",select: false),
                     ClubLevel(name: "上級",select: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubExplanationTV.placeholder = "クラブの紹介（任意1,000文字以内）\n紹介するために紹介するために紹介するために紹介するために紹介するために）\n\n例）ために紹介するために"
        // Do any additional setup after loading the view.
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cameraTapped(tapGestureRecognizer:)))
        cameraUIView.isUserInteractionEnabled = true
        cameraUIView.addGestureRecognizer(tapGestureRecognizer)
        
        handleTextField()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
            
        //clubAddress = ClubAddress(postCode: "", cityName: "へろ", ward: "", address1: "", address2: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //When unwind from NumberOfCourtTVC to CreateClubTVC, assign courtDetailLabel to new value
        if let _clubCourtNum = clubCourtNum {
            courtDetailLabel.text = _clubCourtNum
        }
        //When unwind from AddAddressView to CreateClubTVC, assign addressLabel to new value
        if let _clubAddress = clubAddress {
            addressLabel.text = _clubAddress.cityName
            
        }
        //When unwind from ClubLevelView to CreateClubTVC, assign clubLevelLabel.text to new value
        var str = ""
        for eachClubLevel in clubLevel {
            if eachClubLevel.select {
                str = str + eachClubLevel.name! + "、"
            }
        }
        if str != "" {
            clubLevelLabel.text = str.substring(to: str.index(before: str.endIndex))
        }
        
        
    }
    
    func handleTextField() {
        clubNameTextField.addTarget(self, action: #selector(CreateClubTVC.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange(){
        
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
                self.present(imagePicker,animated: true,completion: nil)
            }
            
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        // Your action
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            cameraUIImageView.image = selectedImage
            cameraUIImageView.contentMode = .scaleAspectFill
            cameraUIImageView.clipsToBounds = true
            
            let leadingConstrain = NSLayoutConstraint(item: cameraUIImageView, attribute: .leading, relatedBy: .equal, toItem: cameraUIImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
            leadingConstrain.isActive = true
            
            let trailingConstrain = NSLayoutConstraint(item: cameraUIImageView, attribute: .trailing, relatedBy: .equal, toItem: cameraUIImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
            trailingConstrain.isActive = true
            
            let topConstrain = NSLayoutConstraint(item: cameraUIImageView, attribute: .top, relatedBy: .equal, toItem: cameraUIImageView.superview, attribute: .top, multiplier: 1, constant: 0)
            topConstrain.isActive = true
            
            let bottomConstrain = NSLayoutConstraint(item: cameraUIImageView, attribute: .bottom, relatedBy: .equal, toItem: cameraUIImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
            bottomConstrain.isActive = true
            
            
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
            destinationController.clubCourtNum = clubCourtNum
            
        }
        if segue.identifier == "showAddAddress" {
            let destinationController = segue.destination as! AddAddress
            destinationController.clubAddress = clubAddress
            
        }
        if segue.identifier == "showClubLevel" {
            let destinationController = segue.destination as! ClubLevelVC
            destinationController.clubLevel = clubLevel
        }
    }
    
   
    
    

}
