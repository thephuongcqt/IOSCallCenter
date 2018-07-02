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
    public typealias Object = NSDate
    public typealias JSON = String
    
    var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = timeTransformFormat
        df.locale = Locale(identifier: "vi_VN")
        df.timeZone = TimeZone(secondsFromGMT: 7)
        return df
    }()
    
    convenience init(dateFormat: String){
        self.init()
        self.dateFormatter.dateFormat = dateFormat
    }
    
    override func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String{
            return self.dateFormatter.date(from: dateString)
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
