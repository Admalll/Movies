// MoviesViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesViewController: UIViewController {
    enum Const {
        static let imagePath = "https://image.tmdb.org/t/p/w500"
        static let reuseIdentifier = "MoviesTableViewCell"
        static let title = "Movies"
    }

    // MARK: - Private properties

    private let moviesView = MoviesView()
    private let model = FilmRequest()
    private let imageLoader = ImageLoader()
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
        title = Const.title
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.reuseIdentifier) as? MoviesTableViewCell
        else { return UITableViewCell() }
        let movie = movies[indexPath.row]

        cell.setupMovieCell(with: movie)

        guard let URL = URL(string: "\(Const.imagePath)\(movie.posterPath)") else { return cell }
        cell.currentURL = URL

        if let image = imageLoader.getImage(url: URL) {
            cell.setupMovieImage(with: image)
            return cell
        }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: URL) else { return }
            guard let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                if URL == cell.currentURL {
                    cell.setupMovieImage(with: image)
                    self.imageLoader.setImage(url: URL, image: image)
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        vc.setupDetailsView(movie: movies[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesViewController: UITableViewDelegate {}
