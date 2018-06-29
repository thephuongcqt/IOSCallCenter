//
//  AppointmentService.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/28/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AppointmentService{
    static let shared = AppointmentService()
    private init(){
        
    }
    
    private let service = BaseService.shared
    
    func getAppointments(with params: [String: Any], completion: @escaping completionHandler<getAppointmentsType>){
        if let url = service.getAbsoluteUrl(from: appointmentsUrl){
            service.getParams(with: url, parameters: params) { (result: getAppointmentsType) in
                completion(result)
            }
        }
    }
}

