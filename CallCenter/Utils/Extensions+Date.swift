//
//  Extensions+Date.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

extension Date{
    static let df: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "vi_VN")
        df.timeZone = TimeZone(secondsFromGMT: 7)
        return df
    }()
    
    init(value: String, format: String) {
        Date.df.dateFormat = format
        self =  Date.df.date(from: value) ?? Date()
    }
    
    static let timeFormat = "HH:mm"
    
    func getDate(fromString date: String, with format: String) -> Date?{
        Date.df.dateFormat = format
        return Date.df.date(from: date)
    }
    
    func toWorkingTime() -> String{
        Date.df.dateFormat = Date.timeFormat
        return Date.df.string(from: self)
    }
    
    func toTimeString() -> String{
        Date.df.dateFormat = "HH"
        var result = Date.df.string(from: self)
        Date.df.dateFormat = "mm"
        result += "h\(Date.df.string(from: self))"
        return result
    }
    func toDateString(with format: String) -> String{
        Date.df.dateFormat = format
        return Date.df.string(from: self)
    }
    
    func getYear() -> String{
        Date.df.dateFormat = "yyyy"
        return Date.df.string(from: self)
    }
    
    func getMonth() -> String{
        Date.df.dateFormat = "MM"
        return Date.df.string(from: self)
    }
    
    func getDay() -> String{
        Date.df.dateFormat = "dd"
        return Date.df.string(from: self)
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
