// MoviesViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesViewController: UIViewController {
    // MARK: - Private properties

    private let moviesView = MoviesView()
    private let model = FilmRequest()
    private var movies: [Results] = [] {
        didSet {
            DispatchQueue.main.async {
                self.moviesView.reloadTableViewData()
            }
        }
    }

    // MARK: - UIViewController

    override func loadView() {
        view = moviesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private methods

    private func setupView() {
        title = "Movies"
        moviesView.setupTableViewDatasource(viewController: self)
        loadMovies()
    }

    private func loadMovies(type: Int = 0) {
        model.getFilms(type: type) { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(movies):
                self?.movies = movies
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell
        else { return UITableViewCell() }
        cell.setupMovieCell(with: movies[indexPath.row])
        cell.setupMovieImage(with: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        vc.setupDetailsView(movie: movies[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesViewController: UITableViewDelegate {}
