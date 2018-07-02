
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
    
//    func getParams(with url: URL, completion: @escaping (_ dictionary: [String: Any]?, _ success: Bool, _ error: Error?) -> ()){
//        Alamofire.request(url).responseJSON { (response) in
//            if response.error != nil{
//                completion(nil, false, response.error)
//                return
//            }
//            if let dictionary = response.result.value as? [String: Any]{
//                completion(dictionary, true, nil)
//            } else{
//                completion(nil, false, nil)
//            }
//        }
//    }
    
    
//    func requestJSON(with url: URL, method: HTTPMethod, parameters: [String: Any], completion: @escaping (_ dictionary: [String: Any]?, _ error: String?) -> ()){
//        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseJSON { (response) in
//            switch response.result{
//            case .success(let value):
//                if let json = value as? [String: Any]{
//                    completion(json, nil)
//                } else{
//                    completion(nil, errorNetworking)
//                }
//            case .failure(let error):
//                completion(nil, error.localizedDescription)
//            }
//        }
//    }
//
//    func requestJSON<T: Mappable>(with url: URL, method: HTTPMethod, parameters: [String: Any], completion: @escaping (_ result: T?, _ error: String?) -> ()){
//        Alamofire.request(url, method: method, parameters: parameters).validate(statusCode: 200...300).responseObject { (resonse: DataResponse<T>) in
//            switch resonse.result{
//            case .success(let value):
//                completion(value, nil)
//            case .failure(let error):
//                completion(nil, error.localizedDescription)
//            }
//        }
//        completion(nil, errorNetworking)
//    }
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
