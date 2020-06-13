//
//  Manager.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

class Manager:NSObject {
    
    private var session: URLSession?
    private var queue: CallbackQueue = .main
    
    public init(configuration: URLSessionConfiguration = .default, callbackQueue: CallbackQueue = .main) {
        super.init()
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        queue = callbackQueue
    }
    
    deinit {
        session = nil
    }
    
    public func send<Request: RequestService>(_ request: Request, callbackQueue: CallbackQueue? = nil, success: @escaping (_ response: [Repository]) -> Void, failure: @escaping (_ error: GithubError) -> Void) {
        
        let queue = callbackQueue ?? self.queue
        let serverRequest: URLRequest
        
        do {
            serverRequest = try request.build()
        } catch {
            queue.execute {
                failure(.requestError(error))
            }
            return
        }
        
        serverRequest.showLog()
        
        let task = session?.dataTask(with: serverRequest) { data, urlResponse, error in
            
            switch (data, urlResponse, error) {
            case (let data, let urlResponse as HTTPURLResponse, let error?):
                urlResponse.showLog(from: data)
                
                queue.execute {
                    failure(.connectionError(error))
                }
            case (let data?, let urlResponse as HTTPURLResponse, _):
                urlResponse.showLog(from: data)
                
                guard 200..<300 ~= urlResponse.statusCode else {
                    queue.execute {
                        failure(.wrongStatusCode(urlResponse.statusCode))
                    }
                    return
                }
                
                
                let requestResult = request.result(from: data)
                
                queue.execute {
                    success(requestResult)
                }
                    
            default:
                queue.execute {
                    failure(.nonURLResponse(urlResponse))
                }
            }
        }
        
        task?.resume()
    }
}

extension Manager: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
