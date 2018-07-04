
//
//  BaseService.swift
//  DemoSwift
//
//  Created by Nguyen The Phuong on 12/11/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol ResponseDelegate {
    func onSuccess<T>(result: T)
    func onFailure(error: Error)
}

class BaseService{
    public init(){        
    }
    
    internal func getAbsoluteUrl(from url: String) -> URL?{
        let urlString = baseUrl + url
        if let absoluteUrl = URL(string: urlString){
            return absoluteUrl
        }
        return nil
    }
    
    internal func getParams<T: Mappable>(with url: URL, parameters: [String: Any], completion: @escaping (ResultType<T>) -> ()){
        Alamofire.request(url, method: .get, parameters: parameters).validate(statusCode: 200...300).responseObject { (resonse: DataResponse<T>) in
            switch resonse.result{
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    internal func postParams<T: Mappable>(with url: URL, parameters: [String: Any], completion: @escaping (ResultType<T>) -> ()){
        Alamofire.request(url, method: .post, parameters: parameters).validate(statusCode: 200...300).responseObject { (resonse: DataResponse<T>) in
            switch resonse.result{
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
