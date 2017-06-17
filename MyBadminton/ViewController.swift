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
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController, FUIAuthDelegate  {
    
    
    
    // You need to adopt a FUIAuthDelegate protocol to receive callback
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        login()
    }
    
    func login(){
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth()
            //FUITwitterAuth(),
            //FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
        ]
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.providers = providers
        authUI?.delegate = self
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)

        
    }
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
    
        if error != nil {
            //Problem signing in
            login()
        }else {
            //User is in! Here is where we code after signing in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}




















