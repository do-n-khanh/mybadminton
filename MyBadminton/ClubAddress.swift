//
//  ClubAddress.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/19.
//  Copyright © 2017 MyBadminton. All rights reserved.
//

import Foundation

class ClubAddress {
    var postCode = ""
    var cityName = ""
    var ward = ""
    var address1 = ""
    var address2 = ""

    
    init(postCode: String, cityName: String, ward: String, address1: String, address2: String) {
        self.postCode = postCode
        self.cityName = cityName
        self.ward = ward
        self.address1 = address1
        self.address2 = address2
        
    }
}
