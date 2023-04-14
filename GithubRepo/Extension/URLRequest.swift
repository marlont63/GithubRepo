//
//  URLRequest.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

extension URLRequest {
    
    func showLog() {
        var body: String? = nil
        if let json: Data = httpBody {
            body = String(data: json, encoding: .utf8)
        }
        let logMessage: String =
        """
        ====== REQUEST ======
        Method: \(httpMethod ?? "NOT DEFINED")
        URL: \(url?.absoluteString ?? "NOT DEFINED")
        HEADERS: \(allHTTPHeaderFields?.description ?? "NOT DEFINED")
        BODY: \(body ?? "NOT DEFINED")
        """
        print(logMessage)
    }
}
