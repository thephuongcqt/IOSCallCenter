//
//  Extensions+Date.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

extension Date{
    
    func toTimeString() -> String{
        let df = DateFormatter()
        df.dateFormat = "HH"
        var result = df.string(from: self)
        df.dateFormat = "mm"
        result += "h\(df.string(from: self))"
        return result
    }
    func toDateString(with format: String) -> String{
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
