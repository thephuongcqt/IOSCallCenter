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

class AppointmentService: BaseService{
    static let shared = AppointmentService()
    private override init(){
        super.init()
    }
    
    func getAppointments(with params: [String: Any], completion: @escaping completionHandler<getAppointmentsType>){
        if let url = getAbsoluteUrl(from: appointmentsUrl){
            getParams(with: url, parameters: params) { (result: getAppointmentsType) in
                completion(result)
            }
        }
    }
}

