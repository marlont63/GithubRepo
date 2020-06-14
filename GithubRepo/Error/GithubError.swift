//
//  GithubError.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

enum GithubError : Swift.Error {
    case connectionError(Error)
    case requestError(Error)
    case nonURLResponse(URLResponse?)
    case wrongStatusCode(Int)
}
