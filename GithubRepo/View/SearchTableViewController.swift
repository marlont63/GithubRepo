//
//  SearchTableViewController.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewProtocol: BaseViewProtocol {
    func showRepositories()
    func showResultSearch(searchText: String?)
}

class SearchTableViewController: BaseViewController {
    
    let dataSource = GithubDataSource()
    private var presenter:SearchPresenter<SearchTableViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SearchPresenter(self)
        presenter?.getGithubRepositories()

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Buscar github repo"
        navigationItem.searchController = search
        
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.searchRepository(searchText: searchController.searchBar.text)
    }
}

extension SearchTableViewController: SearchViewProtocol {
    func showRepositories() {
        
        dataSource.dataChanged = {
            [weak self] in self?.tableView.reloadData()
        }
        
        dataSource.fetch()
        self.tableView.dataSource = dataSource
    }
    
    func showResultSearch(searchText: String?) {
        dataSource.searchRepository(searchText: searchText)
    }
}
