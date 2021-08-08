// FilmRequest.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

final class FilmRequest {
    // MARK: - Public Methods

    public func getFilms(type: Int, complition: @escaping (Result<[Results], Error>) -> Void) {
        let adress =
            "https://api.themoviedb.org/3/movie/popular?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US&page=1"
        guard let url = URL(string: adress) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jdata = data else {
                complition(.failure(fatalError()))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let film = try decoder.decode(Film.self, from: jdata)
                let details = film.results
                complition(.success(details))
            } catch {
                print("Error serialization json", error)
            }
        }
        dataTask.resume()
    }

    public func getFilmDetails(filmID: Int, complition: @escaping (Result<Results, Error>) -> Void) {
        let adress =
            "https://api.themoviedb.org/3/movie/\(filmID)?api_key=9ad7d04f6206bfa729848e1f3f2ffb2d&language=en-US"
        guard let url = URL(string: adress) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let jdata = data else {
                complition(.failure(fatalError()))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(Results.self, from: jdata)
                complition(.success(results))
            } catch {
                print("Error serialization json", error)
            }
        }
        dataTask.resume()
    }
}
