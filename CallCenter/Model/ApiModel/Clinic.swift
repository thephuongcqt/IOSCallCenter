//
//  User.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/11/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation
import ObjectMapper

class Clinic: Mappable {
    var username: String?
    var phoneNumber: String?
    var role: Int?
    var isActive: Int?
    var fullName: String?
    var email: String?
    var address: String?
    var clinicName: String?
    var examinationDuration: String?
    var expiredLicense: Date?
    var currentTime: Date?
    var imageURL: String?
    var greetingURL: String?
    var workingHours: [WorkingHour]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        phoneNumber <- map["phoneNumber"]
        role <- map["role"]
        isActive <- map["isActive"]
        fullName <- map["fullName"]
        email <- map["email"]
        clinicName <- map["clinicName"]
        examinationDuration <- map["examinationDuration"]
        expiredLicense <- (map["expiredLicense"], BaseDateTransform())
        currentTime <- (map["currentTime"], BaseDateTransform())
        imageURL <- map["imageURL"]
        greetingURL <- map["greetingURL"]
        workingHours <- map["workingHours"]
    }
}
