//
//  MoviesModelLogic.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 3/7/22.
//

import Foundation

enum SortType {
    case descendent, ascendent, none
}

final class MoviesModelLogic {
    static let shared = MoviesModelLogic()
    
    var moviesResponse:MovieResponse?
    var movies: [Movie] = []
    
    var search = ""
    
    //NEW
    var filterMovies:[Movie] {
        if search.isEmpty {
            return movies
        } else {
            return movies.filter {
                return $0.title.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func loadMovies(page:Int, language:String) async {
        do {
            moviesResponse = try await getMovies(page: page, language: language)
            if let movies = moviesResponse?.results {
                self.movies.append(contentsOf: movies)
            }
        } catch LoadErrors.general(let error) {
            print("Error general en la carga \(error)")
        } catch LoadErrors.JSONDecoding(let errorJSON) {
            print("Fallo al cargar el JSON: \(errorJSON)")
        } catch LoadErrors.response(let status) {
            print("HTTP Status incorrecto: \(status)")
        } catch {
            print("Error genérico \(error)")
        }
    }
}
