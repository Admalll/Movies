// DetailsMovieView.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class DetailsMovieView: UIView {
    // MARK: - Visual components

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let movieDescriptionLabel = UILabel()

    // MARK: - Initializators

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func setupMovieDetails(movie: Results) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview

        let address = "https://image.tmdb.org/t/p/w500/\(movie.posterPath)"
        guard let URL = URL(string: address) else { return }
        DispatchQueue.main.async {
            guard let data = try? Data(contentsOf: URL) else { return }
            self.movieImageView.image = UIImage(data: data)
        }
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .white

        setupMovieImageView()
        setupNameLabel()
        setupDescriptionLabel()
    }

    private func setupDescriptionLabel() {
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDescriptionLabel.numberOfLines = 0
        movieDescriptionLabel.adjustsFontSizeToFitWidth = true
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        movieDescriptionLabel.text =
            """
            Под влиянием демонической магии Скверны родной мир расы орков Дренор умирает.
            Чтобы спасти свой народ от гибели, вожди всех кланов приводят всех к Тёмному Порталу,
            где орочий чернокнижник Гул’дан
            """
        movieDescriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20)
            .isActive = true
        movieDescriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20)
            .isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40)
            .isActive = true
    }

    private func setupNameLabel() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.text = "Warcraft 2"
        movieNameLabel.textAlignment = .center
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        movieNameLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.numberOfLines = 2
        movieNameLabel.leftAnchor.constraint(equalTo: movieImageView.leftAnchor, constant: 40).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -40).isActive = true
        movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20).isActive = true
        movieNameLabel.bottomAnchor.constraint(equalTo: movieDescriptionLabel.topAnchor, constant: -40).isActive = true
    }

    private func setupMovieImageView() {
        addSubview(movieImageView)
        addSubview(movieNameLabel)
        addSubview(movieDescriptionLabel)

        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        movieImageView.backgroundColor = .black
        movieImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 40).isActive = true
        movieImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -40).isActive = true
        movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
}
