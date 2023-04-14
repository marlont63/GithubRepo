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
//    func showSearchResult(findedRepositories: [Repository])
//    func showGithubRepositoryDetail(repository:Repository)
//    func showNotFindedDataMensage(msg: String)
    func startActivityIndicator()
    func stopActivityIndicator()
//    func cleanUpTableView()
//    func seachLimitExceeded()
//    func seachLimitExceededShowMsg(msg:String)
//    func checkTotalItemsCount(totalCount: Int)
//    func showLoadMoreDataResult(repositories: [Repository])
}

class SearchTableViewController: BaseViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!    
    var repositories = [Repository]()
    private var presenter:SearchPresenter<SearchTableViewController>?
    private var currentPage = 1
    private var shouldShowLoadingCell = false
    private var searchQueryText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(self)
        self.activityIndicator.startAnimating()
        presenter?.getGithubRepositories()
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search github repository"
        search.automaticallyShowsCancelButton = false
        navigationItem.searchController = search
    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let count = repositories.count
//        return shouldShowLoadingCell ? count + 1 :  count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if isLoadingIndexPath(indexPath) {
//            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
//            loadingCell.activityIndicator.startAnimating()
//            return loadingCell
//        } else {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RepositoryTableViewCell {
//                let repositorie = repositories[indexPath.row]
//                cell.config(repository: repositorie)
//                return cell
//            }
//        }
//        return UITableViewCell()
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showRepositoryDetail" {
//            if let destionation = segue.destination as? RepositoryDetailViewController {
//                destionation.repository = sender as? Repository
//            }
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let repository = self.repositories[indexPath.row]
//        presenter?.goToRepositoryDetail(repository: repository)
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100;
//    }
//
//    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
//        guard shouldShowLoadingCell else { return false }
//        return indexPath.row == self.repositories.count
//    }
//
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard isLoadingIndexPath(indexPath) else { return }
//        currentPage += 1
//        presenter?.loadMoreData(page: currentPage, searchQueryText: searchQueryText)
//    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchQueryText = searchController.searchBar.text ?? "all"
        self.presenter?.searchRepository(searchText: searchQueryText)
    }
}

extension SearchTableViewController: SearchViewProtocol {
//    func seachLimitExceeded() {
//        self.shouldShowLoadingCell = false
//        self.tableView.reloadData()
//    }
//
//    func checkTotalItemsCount(totalCount: Int) {
//        self.shouldShowLoadingCell =  repositories.count < totalCount ? true : false
//    }
//
//    func showLoadMoreDataResult(repositories: [Repository]) {
//        self.repositories += repositories
//        self.tableView.reloadData()
//    }
//
//    func cleanUpTableView() {
//        self.repositories = [Repository]()
//        self.tableView.reloadData()
//        self.tableView.backgroundView  = nil
//    }
//
    func startActivityIndicator() {
        self.activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        self.activityIndicator.stopAnimating()
    }
//
//    func showNotFindedDataMensage(msg:String) {
//        self.shouldShowLoadingCell = false
//        self.repositories = [Repository]()
//        self.tableView.reloadData()
//        showTableViewErrorMsg(msg: msg)
//    }
//
//    func showTableViewErrorMsg(msg:String) {
//        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
//        noDataLabel.text          = msg
//        noDataLabel.textColor     = UIColor.red
//        noDataLabel.textAlignment = .center
//        self.tableView.backgroundView  = noDataLabel
//        self.tableView.separatorStyle  = .none
//    }
//
//    func showGithubRepositoryDetail(repository: Repository) {
//        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
//        performSegue(withIdentifier: "showRepositoryDetail", sender: repository)
//    }
//
//    func showSearchResult(findedRepositories: [Repository]) {
//        self.tableView.backgroundView = nil
//        self.repositories = findedRepositories
//        self.shouldShowLoadingCell = true
//        self.tableView.reloadData()
//    }
//
//    func seachLimitExceededShowMsg(msg:String) {
//        self.shouldShowLoadingCell = false
//        self.repositories = [Repository]()
//        self.tableView.reloadData()
//        showTableViewErrorMsg(msg: msg)
//    }
}


