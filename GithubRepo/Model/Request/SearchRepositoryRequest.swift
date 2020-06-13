//
//  SearchRepositoryRequest.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

class SearchRepositoryRequest {
    var searchQuery:String
    
    init(searchQuery: String) {
        self.searchQuery = searchQuery
    }
}

extension SearchRepositoryRequest: GithubApiRequest {
    
    var path: URL {
        
        let urlPath = "search/repositories"
        let searchQuery = self.searchQuery.replacingOccurrences(of: " ", with: "+")
        let parameters = [
            "q":searchQuery,
            "sort": "stars",
            "order": "desc"
        ]
        var completeURLComponents = URLComponents(string: baseURL.absoluteString + urlPath)!
        completeURLComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: String(value))
        })
        
        return completeURLComponents.url ?? baseURL
    }
    
    typealias Response = SearchRepository
}
