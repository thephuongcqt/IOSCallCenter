//
//  PaypalService.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/2/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

class PaymentService: BaseService {
    static let shared = PaymentService()
    
    private override init(){
        super.init()
    }
    
    func getClientToken(completion: @escaping completionHandler<getPaymentTokenType>){
        if let url = getAbsoluteUrl(from: getPaymentTokenUrl){
            getParams(with: url, parameters: [:]) { (result: getPaymentTokenType) in
                completion(result)
            }
        }
    }
}
