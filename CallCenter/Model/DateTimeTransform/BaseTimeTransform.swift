//
//  BaseTimeTransform.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseTimeTransform: DateTransform {
    
    convenience init(dateFormat: String){
        self.init()
    }
    
    override func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String{
            return Date(value: dateString, format: timeTransformFormat)
        }
        return nil
    }
    
    override func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}
