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
    func showGithubRepositoryDetail(repository:Repository)
    func showNoSearchResultMsg()
    func showResultError()
    func startActivityIndicator()
    func stopActivityIndicator()
    func cleanTableView()
}

class SearchTableViewController: BaseViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var repositories = [Repository]()
    private var presenter:SearchPresenter<SearchTableViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SearchPresenter(self)
        self.activityIndicator.startAnimating()
        presenter?.getGithubRepositories()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search github repository"
        navigationItem.searchController = search
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RepositoryTableViewCell {
            let repositorie = repositories[indexPath.row]
            cell.config(repository: repositorie)
            return cell
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepositoryDetail" {
            if let destionation = segue.destination as? RepositoryDetailViewController {
                destionation.repository = sender as? Repository
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = self.repositories[indexPath.row]
        presenter?.goToRepositoryDetail(repository: repository)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter?.searchRepository(searchText: searchController.searchBar.text)
    }
}

extension SearchTableViewController: SearchViewProtocol {
    func cleanTableView() {
        self.repositories = [Repository]()
        self.tableView.reloadData()
        self.tableView.backgroundView  = nil
    }
    
    func startActivityIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
    
    func showResultError() {
        
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        noDataLabel.text          = "API rate limit exceeded"
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.tableView.backgroundView  = noDataLabel
        self.tableView.separatorStyle  = .none
    }
    
    func showNoSearchResultMsg() {
        
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        noDataLabel.text          = "We couldn’t find any repositories matching"
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.tableView.backgroundView  = noDataLabel
        self.tableView.separatorStyle  = .none
    }
    
    func showGithubRepositoryDetail(repository: Repository) {
        view.endEditing(true)
        performSegue(withIdentifier: "showRepositoryDetail", sender: repository)
    }
    
    func showRepositories(repositories: [Repository]) {
        self.repositories = repositories
        self.tableView.reloadData()
    }
    
    func showSearchResult(findedRepositories: [Repository]) {
        self.repositories = findedRepositories
        self.tableView.reloadData()
    }
}


