//
//  RepositoryRequest.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

class RepositoryRequest {}

extension RepositoryRequest: GithubApiRequest {
    
    var path: URL {
        let urlPath = "repositories"
        return baseURL.appendingPathComponent(urlPath)
    }
    
    typealias Response = Repository
}
