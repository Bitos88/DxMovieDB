//
//  MoviesListTableViewController.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 1/7/22.
//

import UIKit

final class MoviesListTableViewController: UITableViewController {
    
    //MARK: PROPERTIES
    let modelLogic = MoviesModelLogic.shared
    var isLoading:Bool = false
    var currentPage = 1

    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        createSerchBar()
        
        Task {
            await modelLogic.loadMovies(page: currentPage, language: "es-ES")
            tableView.reloadData()
        }
    }

    // MARK: TABLEVIEW DATASOURCE AND DELEGATE
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelLogic.filterMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? MoviesListTableViewCell else { return UITableViewCell() }
        
        let movie = modelLogic.filterMovies[indexPath.row]
        
        cell.title.text = movie.title
        cell.overview.text = movie.overview
        cell.voteAverage.text = "Score: \(movie.voteAverage)"
        cell.cover.load(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == modelLogic.filterMovies.count - 10,
           !isLoading {
                loadMoreData()
            }
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail",
           let destination = segue.destination as? MovieDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            destination.movie = modelLogic.movies[indexPath.row]
        }
    }
    
    //MARK: PRIVATE FUNCS
    
    private func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            self.currentPage += 1
            Task {
                await modelLogic.loadMovies(page: currentPage, language: "es-ES")
                tableView.reloadData()
                self.isLoading = false
            }
        }
    }
}

extension MoviesListTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        modelLogic.search = searchController.searchBar.text ?? ""
        
        tableView.reloadData()
    }
    
    private func createSerchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search a Film"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
    }
}
