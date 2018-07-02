//
//  ResultType.swift
//  StudyQuizIOS
//
//  Created by Nguyen The Phuong on 12/19/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import Foundation

enum ResultType<T>{
    case success(T)
    case failure(error: Error)
}

enum BaseError: Error{
    case unknowError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
}
