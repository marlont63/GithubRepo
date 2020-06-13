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
        
        let repositoryRequest = RepositoryRequest()
        let requestService = RequestService()
        requestService.send(repositoryRequest, success: { (repositories) in
            self.view?.showRepositories(repositories: repositories)
        }) { (githubError) in
            print(githubError.localizedDescription)
        }
    }
    
    func searchRepository(searchText: String?){
        
        if let searchText = searchText, searchText.count > 0 {
            
            let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: searchText)
            let requestService = RequestService()
            
            requestService.send(searchRepositoryRequest, success: { (findedRepositories) in
                self.view?.showSearchResult(findedRepositories: findedRepositories)
            }) { (githubError) in
                print(githubError.localizedDescription)
            }
        }else {
            getGithubRepositories()
        }
    }
}
