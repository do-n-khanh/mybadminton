//
//  ViewController.swift
//  MyBadminton
//
//  Created by APPLE on 2017/06/10.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuthUI

import FirebaseDatabaseUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage

class HomeVC: UIViewController, FUIAuthDelegate  {
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBAction func logOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        
    }
    var ref: DatabaseReference!
    
    
    
    
    let kFirebaseTermsOfService = URL(string: "https://firebase.google.com/terms/")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggedIn()
        ref = Database.database().reference()
        //loadPhoto()
        
    }
    
    
    func loadPhoto() {
        let photoRef = Database.database().reference()
        
        photoRef.child("photo").observe(DataEventType.childAdded, with: { (photoSnapshot) in
            if let photoDict = photoSnapshot.value as? [String : AnyObject] {
                let image = UIImageView()
                
                if let main = photoDict["main"] as? String {
                    image.sd_setImage(with: URL(string: main)!)
                    
                } else if let main = photoDict["sub1"] as? String {
                    image.sd_setImage(with: URL(string: main)!)
                } else if let main = photoDict["sub2"] as? String {
                    image.sd_setImage(with: URL(string: main)!)
                } else if let main = photoDict["sub3"] as? String {
                    image.sd_setImage(with: URL(string: main)!)
                }
            }
        })
        
    }
    
    
    func checkLoggedIn() {
        
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                //                self.userInfoLabel.text = user!.displayName!
                //                self.logOutButton.isHidden = false
                
            } else {
                // No user is signed in.
                self.login()
            }
        }
    }
    
    
    
    func login(){
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUITwitterAuth(),
            //FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
        ]
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.tosurl = kFirebaseTermsOfService
        authUI?.providers = providers
        authUI?.delegate = self
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
        
        
    }
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        
        if error != nil {
            //Problem signing in
            print("If there is error, call login")
            login()
        }else {
            //User is in! Here is where we code after signing in
            //create new user in realtime database
            
            let uId = user!.uid
            let uEmail = user!.email ?? ""
            let uDisplayName = user!.displayName ?? ""
            let uPhotoURL = user!.photoURL?.absoluteString ?? ""
            
            let userRef = ref.child("users")
            let newUserRef = userRef.child(uId)
            
            newUserRef.setValue(["displayName":uDisplayName,"email":uEmail,"photoURL":uPhotoURL])
            
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue){
        
    }
    
}




















