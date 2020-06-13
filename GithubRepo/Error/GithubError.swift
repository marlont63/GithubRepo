//
//  GithubError.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

enum GithubError : Swift.Error {
    case signatureNotValid
    case connectionError(Error)
    case requestError(Error)
    case responseError(Error)
    case nonURLResponse(URLResponse?)
    case wrongStatusCode(Int)
    case serverError(Int)
    case malformedURL(URL)
    case wrongErrorServerCode
    
    case noRequestData
        
    case wrongJsonFormat
    case wrongJsonDecodeNames(Error)
    case wrongBodyJsonFormat
    case wrongBodyData
    case internalError
    
    var code: Int {
        switch self {
        case .serverError(let code):
            return code
        case .wrongStatusCode(let code):
            return code
        case .nonURLResponse(_ ):
            return 500
        case .wrongBodyData:
            return 9099
        case .wrongJsonDecodeNames( _):
            return 9099
        default:
            return -1
        }
    }
}
