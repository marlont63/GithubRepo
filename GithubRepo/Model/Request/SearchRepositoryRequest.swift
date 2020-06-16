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
    var page:String
    var itemsPerPage:String
    
    init(searchQuery: String, page:String, itemsPerPage:String) {
        self.searchQuery = searchQuery
        self.page = page
        self.itemsPerPage = itemsPerPage
    }
}

extension SearchRepositoryRequest: GithubApiRequest {
    
    var path: URL {
        
        let urlPath = "search/repositories"
        let searchQuery = self.searchQuery.replacingOccurrences(of: " ", with: "+")
        let parameters = [
            "q":searchQuery,
            "sort": "stars",
            "order": "desc",
            "page":page,
            "per_page":itemsPerPage
        ]
        var completeURLComponents = URLComponents(string: baseURL.absoluteString + urlPath)!
        completeURLComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: String(value))
        })
        
        return completeURLComponents.url ?? baseURL
    }
    
    typealias Response = SearchRepositoryResponse
}
