//
//  License.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class License: Mappable {
    var licenseID: Int?
    var price: Int?
    var duration: Int?
    var name: String?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        licenseID <- map["licenseID"]
        price <- map["price"]
        duration <- map["duration"]
        name <- map["name"]
        description <- map["description"]
    }
}
