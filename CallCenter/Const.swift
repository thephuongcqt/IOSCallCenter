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
let licenseUrl = "license/getAllLicense"
let getPaymentTokenUrl = "paypal/getToken"
let checkOutUrl = "paypal/checkout"
let updateProfileUrl = "clinic/changeClinicProfile"

let keyUsername = "username"
let paramUsername = "username"
let paramPassword = "password"
let paramClinicUsername = "clinicUsername"
let paramAppointmentDate = "date"
let paramLicenseID = "licenseID"
let paramNonce = "nonce"
let paramGreetingUrl = "greetingURL"

let dateFormatForAppointments = "yyyy-MM-dd"
let dateTransformFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
let timeTransformFormat = "HH:mm:ss"
let timeFormat = "HH:mm"
let errorNetworking = "Network error, please try again"

let backTitle = "Trở về"

let defaultStartWorking = Date(value: "17:00:00", format: timeTransformFormat)
let defaultEndWorking = Date(value: "21:00:00", format: timeTransformFormat)
let defaultDuration = Date(value: "00:30:00", format: timeTransformFormat)
let offDayTime = "--:--"
