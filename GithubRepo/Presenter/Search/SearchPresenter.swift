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
        self.view?.showRepositories()
    }
    
    func searchRepository(searchText: String?){
        self.view?.showResultSearch(searchText: searchText)
    }
}
