//
//  HTTPURLResponse.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    func showLog(from data: Data?) {
        var body: String? = nil
        if let json: Data = data {
            body = String(data: json, encoding: .utf8)
        }
        var headers: [String: Any] = [:]
        for (key, value) in allHeaderFields {
            headers[key as! String] = value
        }
        let logMessage: String =
        """
        ====== RESPONSE ======
        STATUS CODE: \(statusCode.description)
        HEADERS: \(headers)
        BODY: \(body ?? "EMPTY RESPONSE")
        """
        print(logMessage)
    }
}
