//
//  Data.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit

class Data: NSObject {
    static var user: Clinic?
    
    static var appoinmentList: [Appointment]?
    
    static var defaults = UserDefaults.standard
    static func getUsername() -> String?{
        return defaults.string(forKey: keyUsername)
    }
    static func setUsername(value username: String?){
        if username == nil{
            defaults.removeObject(forKey: keyUsername)
        } else{
            defaults.setValue(username, forKey: keyUsername)
        }
    }
}
