//
//  Token.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import ObjectMapper

class Token: Mappable {
    var clientToken = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        clientToken <- map["clientToken"]
    }
}
