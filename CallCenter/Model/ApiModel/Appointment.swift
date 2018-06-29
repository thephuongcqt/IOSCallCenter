//
//  Appointment.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/28/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class Appointment: Mappable {
    var appointmentID: Int?
    var appointmentTime: Date?
    var no: Int?
    var currentTime: Date?
    var patientID: Int?
    var phoneNumber: String?
    var fullName: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        appointmentID <- map["appointmentID"]
        appointmentTime <- (map["appointmentTime"], BaseDateTransform())
        no <- map["no"]
        currentTime <- (map["currentTime"], BaseDateTransform())
        patientID <- map["patient.patientID"]
        phoneNumber <- map["patient.phoneNumber"]
        fullName <- map["patient.fullName"]
    }
}
