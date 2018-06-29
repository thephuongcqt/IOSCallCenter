//
//  LoginResponse.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/29/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginResponse<T:Mappable>: Mappable {
    var success: Bool?
    var value: T?
    var error: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        success <- map["status"]
        value <- map["value"]
        error <- map["error"]
    }
}
