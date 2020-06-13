//
//  GithubDataSource.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

class GithubDataSource:  NSObject, UITableViewDataSource {
    
    var repositories = [Repository]()
    var dataChanged: (() -> Void)?
    
    let API_BASE_URL = "https://api.github.com/"
    
    var searchText: String? {
       didSet {
        searchRepository(searchText: searchText)
       }
    }
    
    func searchRepository(searchText: String?) {
        
        if let searchText = searchText, searchText.count > 0 {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let searchQuery = searchText.replacingOccurrences(of: " ", with: "+")

            let url = API_BASE_URL + "search/repositories?q=\(searchQuery)&sort=stars&order=desc"
            
            decoder.decode(SearchRepository.self, fromURL: url) { searchRepositories in
                self.repositories = searchRepositories.items
                self.dataChanged?()
            }
        }else {
            fetch()
        }
    }
    
    func fetch() {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let urlString = API_BASE_URL + "repositories"
        
        decoder.decode([Repository].self, fromURL: urlString) { repositories in
            self.repositories = repositories
            self.dataChanged?()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let repositorie = repositories[indexPath.row]
        cell.textLabel?.text = repositorie.name
        cell.detailTextLabel?.text = repositorie.description
        return cell
    }
}

