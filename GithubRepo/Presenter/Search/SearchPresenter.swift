//
//  SearchPresenter.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation


class SearchPresenter <T: SearchViewProtocol>: BasePresenter<T> {
    
    let requestService = RequestService()
    
    func  getGithubRepositories() {
        
        let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: Constants.defaultQueryText, page:Constants.defaultPage, itemsPerPage:Constants.defaultItemsPerPage)
                
        self.requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
            
            if(searchRepositoriesResponse.items.count > 0) {
                self.view?.stopActivityIndicator()
                self.view?.showSearchResult(findedRepositories: searchRepositoriesResponse.items)
            }else {
                self.view?.stopActivityIndicator()
                self.view?.showNotFindedDataMensage(msg: "NOT_FINDED_DATA_MENSAGE".localized())
            }
            
        }) { (githubError) in
            self.view?.stopActivityIndicator()
            self.view?.seachLimitExceededShowMsg(msg: "SEARCH_LIMIT_EXCEEDED".localized())
        }
    }
    
    func searchRepository(searchText: String?){
        
        if let searchText = searchText, searchText.count > 0, searchText != "" {
            self.view?.startActivityIndicator()
            self.view?.cleanUpTableView()
            let defaultPage = "1"
            let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: searchText, page:defaultPage, itemsPerPage:Constants.defaultItemsPerPage)
                    
            self.requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
                
                if(searchRepositoriesResponse.items.count > 0) {
                    self.view?.stopActivityIndicator()
                    self.view?.checkTotalItemsCount(totalCount: searchRepositoriesResponse.totalCount)
                    self.view?.showSearchResult(findedRepositories: searchRepositoriesResponse.items)
                }else {
                    self.view?.stopActivityIndicator()
                    self.view?.showNotFindedDataMensage(msg: "NOT_FINDED_DATA_MENSAGE".localized())
                }
                
            }) { (githubError) in
                self.view?.stopActivityIndicator()
                self.view?.seachLimitExceededShowMsg(msg: "SEARCH_LIMIT_EXCEEDED".localized())
            }
        }
    }
    
    func loadMoreData(page: Int, searchQueryText: String) {
        
        var loadMoreDataText = Constants.defaultQueryText
        if(searchQueryText != "") {
            loadMoreDataText = searchQueryText
        }
        
        let searchRepositoryRequest = SearchRepositoryRequest(searchQuery: loadMoreDataText, page:page.description, itemsPerPage:Constants.defaultItemsPerPage)
        
        self.requestService.send(searchRepositoryRequest, success: { (searchRepositoriesResponse) in
            
            if(searchRepositoriesResponse.items.count > 0) {
                self.view?.stopActivityIndicator()
                self.view?.checkTotalItemsCount(totalCount: searchRepositoriesResponse.totalCount)
                self.view?.showLoadMoreDataResult(repositories: searchRepositoriesResponse.items)
            }else {
                self.view?.stopActivityIndicator()
                self.view?.showNotFindedDataMensage(msg: "NOT_FINDED_DATA_MENSAGE".localized())
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
