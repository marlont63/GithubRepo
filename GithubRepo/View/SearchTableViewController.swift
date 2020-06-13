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
    func showRepositories(repositories: [Repository])
    func showSearchResult(findedRepositories: [Repository])
}

class SearchTableViewController: BaseViewController {
    
    var repositories = [Repository]()
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let repositorie = repositories[indexPath.row]
        cell.textLabel?.text = repositorie.name
        cell.detailTextLabel?.text = repositorie.description
        return cell
    }
    
}

extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.searchRepository(searchText: searchController.searchBar.text)
    }
}

extension SearchTableViewController: SearchViewProtocol {
    func showRepositories(repositories: [Repository]) {
        self.repositories = repositories
        self.tableView.reloadData()
    }
    
    func showSearchResult(findedRepositories: [Repository]) {
        
        self.repositories = findedRepositories
        self.tableView.reloadData()
        
    }
}


