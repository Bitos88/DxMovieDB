//
//  MovieDetailViewController.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 4/7/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var detailVoteAverage: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        detailTitle.text = movie?.title
        detailDescription.text = movie?.overview
        detailVoteAverage.text = "Vote Average: \(movie?.voteAverage ?? 0)"
        detailImage.load(urlString: "https://image.tmdb.org/t/p/w500\(movie?.backdropPath ?? "")")
    }
}
