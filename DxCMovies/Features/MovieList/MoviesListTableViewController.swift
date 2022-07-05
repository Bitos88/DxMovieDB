//
//  MoviesListTableViewController.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 1/7/22.
//

import UIKit

class MoviesListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let modelLogic = MoviesModelLogic.shared
    
    var originalMoviesArray = [Movie]()
    
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    
        Task {
            await modelLogic.loadMovies(page: currentPage, language: "es-ES")
            modelLogic.movies.forEach { movie in
                self.originalMoviesArray.append(movie)
            }
            tableView.reloadData()
        }
        
        createSerchBar()
    }
    
    
    func createSerchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search a Score"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
    }

    // MARK: - Table view data source

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
        cell.voteAverage.text = "V.A: \(movie.voteAverage)"
        cell.cover.load(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == 10 {
//            currentPage = currentPage + 1
//            
//            Task (priority: .userInitiated) {
//                await modelLogic.loadMovies(page: currentPage, language: "es-ES")
//            }
//            
//            tableView.reloadData()
//        }
//    }
    
    func updateSearchResults(for searchController: UISearchController) {
        modelLogic.search = searchController.searchBar.text ?? ""
        
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail",
           let destination = segue.destination as? MovieDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            destination.movie = modelLogic.movies[indexPath.row]
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
