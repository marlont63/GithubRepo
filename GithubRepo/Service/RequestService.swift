//
//  RequestService.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit


class RequestService {}

extension RequestService {
    
    public func send<Request: GithubApiRequest>(_ request: Request, success: @escaping (_ response: [Repository]) -> Void, failure: @escaping (_ error: GithubError) -> Void) {
        
        let serverRequest: URLRequest
        
        do {
            serverRequest = try request.build()
        } catch {
            
            DispatchQueue.main.async {
                failure(.requestError(error))
            }
            return
        }
        
        serverRequest.showLog()
        
        let task = URLSession.shared.dataTask(with: serverRequest) { data, urlResponse, error in
            
            switch (data, urlResponse, error) {
            case (let data, let urlResponse as HTTPURLResponse, let error?):
                urlResponse.showLog(from: data)
                
                DispatchQueue.main.async {
                    failure(.connectionError(error))
                }
            case (let data?, let urlResponse as HTTPURLResponse, _):
                urlResponse.showLog(from: data)
                
                guard 200..<300 ~= urlResponse.statusCode else {
                    DispatchQueue.main.async {
                        failure(.wrongStatusCode(urlResponse.statusCode))
                    }
                    return
                }
                
                let decode = JSONDecoder()
                
                var requestResult = [Repository]()
                    
                if let response = try? decode.decode([Repository].self, from: data) {
                    requestResult = response
                }else if let response = try? decode.decode(SearchRepository.self, from: data) {
                    requestResult = response.items
                }
                
                DispatchQueue.main.async {
                    success(requestResult)
                }
                    
            default:
                DispatchQueue.main.async {
                    failure(.nonURLResponse(urlResponse))
                }
            }
        }
        
        task.resume()
    }
}
