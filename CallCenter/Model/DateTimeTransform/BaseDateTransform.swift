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
    convenience init(dateFormat: String){
        self.init()
    }
    
    override func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String{
            return Date(value: dateString, format: dateTransformFormat)
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
