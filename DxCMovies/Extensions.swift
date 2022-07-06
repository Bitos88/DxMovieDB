//
//  Extensions.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 3/7/22.
//

import Foundation
import UIKit


extension URL {
    static let baseMoviesURL = "https://api.themoviedb.org/3/movie/popular"
    static let apiKey = "631e5fb6f2fb89b07fc57d0d7120aba8"
    static func buildMovieURL(page: Int, language: String) -> URL {
        URL(string: "\(baseMoviesURL)?api_key=\(apiKey)&language=\(language)&page=\(page)")!
    }
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
