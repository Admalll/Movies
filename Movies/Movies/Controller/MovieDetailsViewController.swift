// MovieDetailsViewController.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MovieDetailsViewController: UIViewController {
    // MARK: - Private properties

    let detailsView = DetailsMovieView()

    // MARK: - UIViewController

    override func loadView() {
        view = detailsView
    }

    // MARK: Public methods

    func setupDetailsView(movie: Results) {
        title = movie.title
        detailsView.setupMovieDetails(movie: movie)
    }
}
