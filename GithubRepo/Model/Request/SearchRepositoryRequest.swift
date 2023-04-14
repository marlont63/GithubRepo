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
    typealias Response = SearchRepositoryResponse
    var path: URL {
        let urlPath: String = "search/repositories"
        let searchQuery: String = self.searchQuery.replacingOccurrences(of: " ", with: "+")
        let parameters: [String: String] = [
            "q":searchQuery,
            "sort": "stars",
            "order": "desc",
            "page":page,
            "per_page":itemsPerPage
        ]
        var completeURLComponents: URLComponents = URLComponents(string: baseURL.absoluteString + urlPath)!
        completeURLComponents.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: String(value))
        })
        
        return completeURLComponents.url ?? baseURL
    }
}
