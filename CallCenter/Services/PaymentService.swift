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
    
    func checkOut(params: [String: Any], completion: @escaping completionHandler<checkOutType>){
        if let url = getAbsoluteUrl(from: checkOutUrl){
            postParams(with: url, parameters: params) { (result: checkOutType) in
                completion(result)
            }
        }
    }
}
