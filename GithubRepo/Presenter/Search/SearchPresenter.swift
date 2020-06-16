//
//  SearchPresenter.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation


class SearchPresenter <T: SearchViewProtocol>: BasePresenter<T> {
    
    let DEFAULT_ITEMS_PER_PAGE = "10"
    let DEFAULT_QUERY_TEXT = "all"
    let DEFAULT_PAGE = "1"
    
    let NOT_FINDED_DATA_MENSAGE = "We couldn’t find any repositories matching"
    let SEARCH_LIMIT_EXCEEDED = "Search limit exceeded"
    
    func  getGithubRepositories() {
        
        let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: DEFAULT_QUERY_TEXT, page:DEFAULT_PAGE, itemsPerPage:DEFAULT_ITEMS_PER_PAGE)
        let requestService = RequestService()
                
        requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
            
            if(searchRepositoriesResponse.items.count > 0) {
                self.view?.stopActivityIndicator()
                self.view?.showSearchResult(findedRepositories: searchRepositoriesResponse.items)
            }else {
                self.view?.stopActivityIndicator()
                self.view?.showNotFindedDataMensage(msg: self.NOT_FINDED_DATA_MENSAGE)
            }
            
        }) { (githubError) in
            self.view?.stopActivityIndicator()
            self.view?.seachLimitExceeded()
        }
    }
    
    func searchRepository(searchText: String?){
        
        if let searchText = searchText, searchText.count > 0, searchText != "" {
            self.view?.startActivityIndicator()
            self.view?.cleanUpTableView()
            let defaultPage = "1"
            let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: searchText, page:defaultPage, itemsPerPage:DEFAULT_ITEMS_PER_PAGE)
            let requestService = RequestService()
                    
            requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
                
                if(searchRepositoriesResponse.items.count > 0) {
                    self.view?.stopActivityIndicator()
                    self.view?.checkTotalItemsCount(totalCount: searchRepositoriesResponse.total_count)
                    self.view?.showSearchResult(findedRepositories: searchRepositoriesResponse.items)
                }else {
                    self.view?.stopActivityIndicator()
                    self.view?.showNotFindedDataMensage(msg: self.NOT_FINDED_DATA_MENSAGE)
                }
                
            }) { (githubError) in
                self.view?.stopActivityIndicator()
                self.view?.seachLimitExceeded()
            }
        }
    }
    
    func loadMoreData(page: Int, searchQueryText: String) {
        
        var loadMoreDataText = DEFAULT_QUERY_TEXT
        if(searchQueryText != "") {
            loadMoreDataText = DEFAULT_QUERY_TEXT
        }
        
        let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: loadMoreDataText, page:page.description, itemsPerPage:DEFAULT_ITEMS_PER_PAGE )
        let requestService = RequestService()
        
        requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
            
            if(searchRepositoriesResponse.items.count > 0) {
                self.view?.stopActivityIndicator()
                self.view?.checkTotalItemsCount(totalCount: searchRepositoriesResponse.total_count)
                self.view?.showLoadMoreDataResult(repositories: searchRepositoriesResponse.items)
            }else {
                self.view?.stopActivityIndicator()
                self.view?.showNotFindedDataMensage(msg: self.NOT_FINDED_DATA_MENSAGE)
            }
            
        }) { (githubError) in
            self.view?.stopActivityIndicator()
            self.view?.seachLimitExceeded()
        }
    }
    
    func goToRepositoryDetail(repository: Repository) {
        self.view?.stopActivityIndicator()
        self.view?.showGithubRepositoryDetail(repository: repository)
    }
}
