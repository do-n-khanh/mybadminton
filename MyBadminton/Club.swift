//
//  Club2.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/08/29.
//  Copyright © 2017 MyBadminton. All rights reserved.
//


import Foundation


class Club {
    var name : String
    var explanation : String
    var courtNum  : Int
    var membershipFee : Int
    var visitorFee : Int
    var hasCarParking : Bool
    
    init( name: String, explanation: String, courtNum: Int,membershipFee : Int,visitorFee : Int ,hasCarParking : Bool ) {
        self.name = name
        self.explanation = explanation
        self.courtNum = courtNum
        self.membershipFee = membershipFee
        self.visitorFee = visitorFee
        self.hasCarParking = hasCarParking
        
    }
    
}
