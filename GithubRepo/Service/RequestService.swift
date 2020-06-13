//
//  RequestService.swift
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

protocol RequestService {
    
    typealias HTTPHeaders = [String : String]
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    
    var path: URL { get }
    
    var method: HTTPMethod { get }
    
    var headers: HTTPHeaders { get }
    
    var timeout: TimeInterval { get }
    
    var sampleData: Data { get }
}

// Default params
extension RequestService {
    
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

// Protocol functions
extension RequestService {
    
    func build() throws -> URLRequest {
        
//        let url = path.isEmpty ? baseURL : URL(string: baseURL.appendingPathComponent(path).absoluteString.removingPercentEncoding!)!
        
        var request = URLRequest(url: path)
        request.timeoutInterval = timeout
        request.httpMethod = method.rawValue
        
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func result(from data: Data) -> [Repository]{
        
        let decode = JSONDecoder()
            
        if let response = try? decode.decode([Repository].self, from: data) {
            return response
        }else if let response = try? decode.decode(SearchRepository.self, from: data) {
            return response.items
        }else {
            return []
        }
    }
}
