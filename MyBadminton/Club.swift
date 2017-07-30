//
//  Club.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/25.
//  Copyright © 2017年 MyBadminton. All rights reserved.
//

import Foundation
class Club {
    var photo : [String]
    var name : String
    var explanation : String
    var courtNum  : String
    var level: [ClubLevel]
    var schedule  : [ClubSchedule]
    var address : ClubAddress
    var membershipFee : String
    var visitorFee : String
    var hasCarParking : Bool
    
    
    init(photo: [String], name: String, explanation: String, courtNum: String, level: [ClubLevel],schedule: [ClubSchedule],address : ClubAddress,membershipFee : String,visitorFee : String ,hasCarParking : Bool ) {
        self.photo = photo
        self.name = name
        self.explanation = explanation
        self.courtNum = courtNum
        self.level = level
        self.schedule = schedule
        self.address = address
        self.membershipFee = membershipFee
        self.visitorFee = visitorFee
        self.hasCarParking = hasCarParking
        
    }
    func create() -> Int {
        
        return 1 //Successfully created. return 0 if failed
    }
}
