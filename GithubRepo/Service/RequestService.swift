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
    
    public func send<Request: GithubApiRequest>(_ request: Request, success: @escaping (_ response: SearchRepositoryResponse) -> Void, failure: @escaping (_ error: GithubError) -> Void) {
        
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
        
        let session = URLSession.shared
        
        session.getAllTasks { (tasks) in
            tasks.forEach { $0.cancel() }
        }
        
        let task = session.dataTask(with: serverRequest) { data, urlResponse, error in
            
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
                
                do {
                    
                    let response = try decode.decode(SearchRepositoryResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        success(response)
                    }
                    
                }catch {
                    DispatchQueue.main.async {
                        failure(.wrongJsonFormat)
                    }
                }

            default:
                DispatchQueue.main.async {
                    failure(.nonURLResponse(urlResponse))
                }
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from url: URL ,success: @escaping (_ image: UIImage) -> Void, failure: @escaping (_ error: GithubError) -> Void){
        
        let session = URLSession(configuration: .default)
        
        let downloadPicTask = session.dataTask(with: url) { (data, urlResponse, error) in
            
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
                 
                 if let image = UIImage(data: data) {
                    success(image)
                 }
            
             default:
                DispatchQueue.main.async {
                    failure(.nonURLResponse(urlResponse))
                }
            }
        }

        downloadPicTask.resume()
    }
}
