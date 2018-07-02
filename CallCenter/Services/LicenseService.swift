//
//  File.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
class LicenseService: BaseService{
    static let shared = LicenseService()
    private override init() {
        super.init()
    }
    
    func getLicense(completion: @escaping completionHandler<getLicenseType>){
        if let url = getAbsoluteUrl(from: licenseUrl){
            getParams(with: url, parameters: [:]) { (result: getLicenseType) in
                completion(result)
            }
        }
    }
}
