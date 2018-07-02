//
//  LoginService.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/11/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginService: BaseService{
    
    static let shared = LoginService()
    private override init(){
        super.init()
    }    
    
    func login(with params: [String: Any], completion: @escaping completionHandler<loginResultType>){
        if let url = getAbsoluteUrl(from: loginUrl){
            postParams(with: url, parameters: params, completion: { (result: loginResultType) in
                completion(result)
            })
        }
    }
    
    func getUserInformation(with params: [String: Any], completion: @escaping completionHandler<loginResultType>){
        if let url = getAbsoluteUrl(from: getInfoUrl){
            postParams(with: url, parameters: params, completion: { (result: loginResultType) in
                completion(result)
            })
        }
    }
}
