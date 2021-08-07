// MoviesView.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesView: UIView {
    enum Const {
        static let buttonNames = ["Popular", "Top Rated", "Up Coming"]
    }

    // MARK: - Visual components

    private var segmentButtons: [UIButton] = []
    private var segmentStackView = UIStackView()
    private var moviesTableView = UITableView()

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

    func setupTableViewDatasource(viewController: MoviesViewController) {
        moviesTableView.dataSource = viewController
        moviesTableView.delegate = viewController
    }

    func reloadTableViewData() {
        moviesTableView.reloadData()
    }

    // MARK: - Private methods

    private func setupView() {
        backgroundColor = .white

        setupSegmentButtons()
        setupSegmentStackView()
        setupMoviesTableView()
    }

    private func setupSegmentButtons() {
        Const.buttonNames.forEach {
            let button = UIButton()
            button.backgroundColor = .systemGray6
            button.setTitleColor(.black, for: .normal)
            button.setTitle($0, for: .normal)
            button.layer.cornerRadius = 5
            segmentButtons += [button]
        }
    }

    private func setupSegmentStackView() {
        addSubview(segmentStackView)
        segmentButtons.forEach { segmentStackView.addArrangedSubview($0) }
        segmentStackView.axis = .horizontal
        segmentStackView.distribution = .fillEqually
        segmentStackView.spacing = 10
        segmentStackView.backgroundColor = .clear
        segmentStackView.translatesAutoresizingMaskIntoConstraints = false
        segmentStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        segmentStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        segmentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }

    private func setupMoviesTableView() {
        addSubview(moviesTableView)
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        moviesTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        moviesTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        moviesTableView.topAnchor.constraint(equalTo: segmentStackView.bottomAnchor, constant: 30).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        moviesTableView.separatorStyle = .none
        moviesTableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "MoviesTableViewCell")
    }
}
