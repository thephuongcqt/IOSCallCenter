//
//  WorkingHour.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class WorkingHour: Mappable {
    var startWorking: Date?
    var endWorking: Date?
    var applyDate: Int?
    var isDayOff: Int?
    
    required init?(map: Map) {
    
    }
    
    init(start: Date?, end: Date?, applyDate: Int?, isDayOff: Int?){
        self.startWorking = start
        self.endWorking = end
        self.applyDate = applyDate
        self.isDayOff = isDayOff
    }
    
    func mapping(map: Map) {
        startWorking <- (map["startWorking"], BaseTimeTransform())
        endWorking <- (map["endWorking"], BaseTimeTransform())
        applyDate <- map["applyDate"]
        isDayOff <- map["isDayOff"]
    }
    
}
