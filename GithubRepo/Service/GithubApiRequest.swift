//
//  GithubApiRequest.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

enum Result<T: Codable> {
    case success(T?)
    case error(GithubError)
}

protocol GithubApiRequest {
    
    typealias HTTPHeaders = [String : String]
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    
    var path: URL { get }
    
    var method: HTTPMethod { get }
    
    var headers: HTTPHeaders { get }
    
    var timeout: TimeInterval { get }
    
    var sampleData: Data { get }
}

extension GithubApiRequest {
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var timeout: TimeInterval {
        return 50
    }
    
    public var headers: HTTPHeaders {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    public var sampleData: Data {
        return Data()
    }
}


extension GithubApiRequest {
    
    func build() throws -> URLRequest {
        
        var request = URLRequest(url: path)
        request.timeoutInterval = timeout
        request.httpMethod = method.rawValue
        
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
