//
//  BaseRequest.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
class BaseRequest{
    static func createParamsUserInfo(username: String) -> [String: Any]{
        return [paramUsername: username]
    }
    
    static func createParamsUserLogin(username: String, password: String) -> [String: Any]{
        return [paramUsername: username, paramPassword: password]
    }
    
    static func createParamsGetAppointment(username: String) -> [String: Any]{
        return [paramClinicUsername: username]
    }
    
    static func createParamsGetAppointmentByDate(username: String, date: Date) -> [String: Any]{
        return [paramClinicUsername: username, paramAppointmentDate: date.toDateString(with: dateFormatForAppointments)]
    }
    
    static func createParamsCheckOut(username: String, licenseID: String, nonce: String) -> [String: Any]{
        return [paramUsername: username, paramLicenseID: licenseID, paramNonce: nonce]
    }
}
