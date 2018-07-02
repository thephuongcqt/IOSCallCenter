//
//  BaseDateTransform.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/19/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseDateTransform: DateTransform{
    
    public typealias Object = NSDate
    public typealias JSON = String
    
    var dateFormatter: DateFormatter = {
       let df = DateFormatter()
        df.dateFormat = dateTransformFormat
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
