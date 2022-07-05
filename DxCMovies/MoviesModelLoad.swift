//
//  MoviesModelLogic.swift
//  DxCMovies
//
//  Created by Alberto Alegre Bravo on 1/7/22.
//

import Foundation

enum LoadErrors:Error {
    case general(Error)
    case response(Int)
    case JSONDecoding(String)
    case serverError(String)
}

func getMovies(page: Int, language: String) async throws -> MovieResponse {
    do {
        let (data, response) = try await URLSession.shared.data(from: .buildMovieURL(page: page, language: language))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw LoadErrors.response((response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        do {
            return try JSONDecoder().decode(MovieResponse.self, from: data)
        } catch {
            throw LoadErrors.JSONDecoding(error.localizedDescription)
        }
    } catch {
        throw LoadErrors.general(error)
    }
}


