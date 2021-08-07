// MoviesTableViewCell.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    // MARK: - Visual components

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    private let movieDateLabel = UILabel()
    private let movieScoreLabel = UILabel()
    private let movieView = UIView()

    // MARK: - UITableViewCell

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0))
    }

    // MARK: - Initializators

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func setupMovieCell(with movie: Results) {
        movieNameLabel.text = movie.title
        movieDescriptionLabel.text = movie.overview
        movieDateLabel.text = movie.releaseDate
        movieScoreLabel.text = String(movie.voteAverage)
    }

    func setupMovieImage(with movie: Results) {
        let address = "https://image.tmdb.org/t/p/w500/\(movie.posterPath)"
        guard let URL = URL(string: address) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: URL) else { return }
            DispatchQueue.main.async {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }

    // MARK: - Private methods

    private func setupCell() {
        setupMovieImageView()
        setupMovieView()
        setupNameLabel()
        setupDescriptionLabel()
        setupDateLabel()
        setupScoreLabel()
    }

    private func setupScoreLabel() {
        movieImageView.addSubview(movieScoreLabel)
        movieScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        movieScoreLabel.layer.masksToBounds = true
        movieScoreLabel.text = "7.7"
        movieScoreLabel.font = UIFont.boldSystemFont(ofSize: 25)
        movieScoreLabel.backgroundColor = .systemGray3
        movieScoreLabel.layer.borderWidth = 3
        movieScoreLabel.layer.borderColor = UIColor.yellow.cgColor
        movieScoreLabel.layer.cornerRadius = 5
        movieScoreLabel.textColor = .black
        movieScoreLabel.textAlignment = .center
        movieScoreLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -10).isActive = true
        movieScoreLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -10).isActive = true
        movieScoreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        movieScoreLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupDateLabel() {
        movieView.addSubview(movieDateLabel)
        movieDateLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDateLabel.numberOfLines = 1
        movieDateLabel.adjustsFontSizeToFitWidth = true
        movieDateLabel.text = "24 марта 2021"
        movieDateLabel.textColor = .black
        movieDateLabel.textAlignment = .right
        movieDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        movieDateLabel.leftAnchor.constraint(equalTo: movieView.leftAnchor, constant: 10).isActive = true
        movieDateLabel.rightAnchor.constraint(equalTo: movieView.rightAnchor, constant: -10).isActive = true
        movieDateLabel.bottomAnchor.constraint(equalTo: movieView.bottomAnchor, constant: -10).isActive = true
        movieDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        movieDateLabel.topAnchor.constraint(equalTo: movieDescriptionLabel.bottomAnchor, constant: 10).isActive = true
    }

    private func setupDescriptionLabel() {
        movieView.addSubview(movieDescriptionLabel)
        movieDescriptionLabel
            .text =
            """
                        Под влиянием демонической магии Скверны родной мир расы орков Дренор умирает.
            Чтобы спасти свой народ от гибели, вожди всех кланов приводят всех к Тёмному Порталу,
            где орочий чернокнижник Гул’дан
            """
        movieDescriptionLabel.numberOfLines = 0
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDescriptionLabel.leftAnchor.constraint(equalTo: movieView.leftAnchor, constant: 10).isActive = true
        movieDescriptionLabel.rightAnchor.constraint(equalTo: movieView.rightAnchor, constant: -10).isActive = true
        movieDescriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 15).isActive = true
    }

    private func setupNameLabel() {
        movieView.addSubview(movieNameLabel)
        movieNameLabel.text = "Mortal Combat"
        movieNameLabel.textAlignment = .center
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 19)
        movieNameLabel.textColor = .black
        movieNameLabel.numberOfLines = 2
        movieNameLabel.adjustsFontSizeToFitWidth = true
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.leftAnchor.constraint(equalTo: movieView.leftAnchor, constant: 10).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: movieView.rightAnchor, constant: -10).isActive = true
        movieNameLabel.topAnchor.constraint(equalTo: movieView.topAnchor, constant: 10).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setupMovieView() {
        contentView.addSubview(movieView)
        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.backgroundColor = .systemGray3
        movieView.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 0).isActive = true
        movieView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        movieView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10).isActive = true
        movieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }

    private func setupMovieImageView() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        contentView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false

        movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        movieImageView.backgroundColor = .black
        movieImageView.contentMode = .scaleAspectFill
    }
}
