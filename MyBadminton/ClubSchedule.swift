//
//  ClubSchedule.swift
//  MyBadminton
//
//  Created by Khanh N. Do on 2017/07/27.
//  Copyright © 2017年 MyBadminton. All rights reserved.
//

import Foundation
class ClubSchedule {
    var type : String!
    var dayInWeek: String!
    var day : String!
    var startTime : String!
    var endTime : String!
    
    init(type: String, dayInWeek : String, day: String, startTime: String, endTime: String) {
        self.type = type
        self.dayInWeek = dayInWeek
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
    }
}


