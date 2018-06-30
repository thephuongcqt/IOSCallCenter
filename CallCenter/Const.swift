//
//  Const.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 6/25/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import Foundation

//let baseUrl = "https://callcenterapi.herokuapp.com/"
let baseUrl = "http://27.74.245.84:8080/"
let loginUrl = "clinic/Login"
let getInfoUrl = "clinic/getClinicInformation"
let appointmentsUrl = "appointment/getAppointmentsListByDate"

let keyUsername = "username"
let paramUsername = "username"
let paramPassword = "password"
let paramClinicUsername = "clinicUsername"
let paramAppointmentDate = "date"

let dateFormatForAppointments = "yyyy-MM-dd"
let dateTransformFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
let timeTransformFormat = "HH:mm:ss"
let timeFormat = "HH:mm"
let errorNetworking = "Network error, please try again"
