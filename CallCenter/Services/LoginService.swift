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

class LoginService{
    
    static let shared = LoginService()
    private init(){
    }    
    
    func login(with params: [String: Any], completion: @escaping completionHandler<loginResultType>){
        
        let service = BaseService.shared
        if let url = service.getAbsoluteUrl(from: loginUrl){
            service.postParams(with: url, parameters: params, completion: { (result: loginResultType) in
                completion(result)
            })
        }
    }
    
    func getUserInformation(with params: [String: Any], completion: @escaping completionHandler<loginResultType>){
        
        let service = BaseService.shared
        if let url = service.getAbsoluteUrl(from: getInfoUrl){
            service.postParams(with: url, parameters: params, completion: { (result: loginResultType) in
                completion(result)
            })
        }
    }
}
