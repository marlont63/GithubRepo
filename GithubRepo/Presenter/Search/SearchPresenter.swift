//
//  SearchPresenter.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation


class SearchPresenter <T: SearchViewProtocol>: BasePresenter<T> {
    
    func  getGithubRepositories() {
        
        let manager = Manager()
        let repositoryRequest = RepositoryRequest()
        
        manager.send(repositoryRequest, success: { (repositories) in
            
            self.view?.showRepositories(repositories: repositories)
            
        }, failure: { (punkError) in
            print("Error")
        })
    }
    
    func searchRepository(searchText: String?){
        
        if let searchText = searchText, searchText.count > 0 {
            
            let manager = Manager()
            let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: searchText)
            
            manager.send(searchRepositoryRequest, success: { (findedRepositories) in
                
                self.view?.showSearchResult(findedRepositories: findedRepositories)
                
            }, failure: { (punkError) in
                print("Error")
            })
            
        }
    }
}
