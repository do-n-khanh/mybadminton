//
//  CreateClubViewController.swift
//  MyBadminton
//
//  Created by APPLE on 2017/06/18.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import UIKit

class CreateClubTVC: UITableViewController {

    @IBOutlet weak var clubExplanationTV: UITextView!
    
    @IBAction func cancelCreateAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        clubExplanationTV.placeholder = "クラブの紹介（任意1,000文字以内）\n紹介するために紹介するために紹介するために紹介するために紹介するために）\n\n例）ために紹介するために"
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
