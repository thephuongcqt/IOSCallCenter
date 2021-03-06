//
//  BaseResponse.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/11/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Mappable{
    var success: Bool?
    var value: [T]?
    var error: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["status"]
        value <- map["value"]
        error <- map["error"]
    }
}

class StringResponse: Mappable{
    var success: Bool?
    var value: String?
    var error: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["status"]
        value <- map["value"]
        error <- map["error"]
    }
}


typealias completionHandler<T> = (T) -> ()

typealias loginResultType = ResultType<BaseSingleResponse<Clinic>>
typealias getAppointmentsType = ResultType<BaseResponse<Appointment>>
typealias getLicenseType = ResultType<BaseResponse<License>>
typealias getPaymentTokenType = ResultType<BaseSingleResponse<Token>>
typealias checkOutType = ResultType<BaseSingleResponse<Clinic>>
typealias updateType = ResultType<BaseSingleResponse<Clinic>>

