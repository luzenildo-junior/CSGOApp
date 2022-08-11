//
//  HomeViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Combine
import Foundation
import UIKit

final class MatchesViewController: BaseViewController {
    private let viewModel: MatchesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(type: MatchTableViewCell.self)
        tableView.accessibilityIdentifier = "matches-tableView"
        return tableView
    }()
    
    init(viewModel: MatchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableCodeView()
        subscribeToPublishers()
        viewModel.fetchTournamentData()
    }
    
    private func subscribeToPublishers() {
        viewModel.$viewState
        .receive(on: DispatchQueue.main)
        .sink { [weak self] viewState in
            guard let self = self else { return }
            switch viewState {
            case .loading:
                self.startLoading()
            case .displayMatches:
                self.stopLoading()
                self.tableView.reloadData()
            case .showError(let message):
                self.showAlert(message: message) { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.fetchTournamentData()
                }
            }
        }.store(in: &cancellables)
    }
}

extension MatchesViewController: CodeView {
    func addViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // tableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViews() {
        title = "home.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        view.accessibilityIdentifier = "matches-view"
    }
}

extension MatchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTableViewNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(for: MatchTableViewCell.self, indexPath: indexPath) else { return UITableViewCell() }
        cell.setupMatchCell(with: viewModel.getCellDisplayableContent(for: indexPath))
        return cell
    }
}

extension MatchesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getTableViewNumberOfRows() - 1 {
            viewModel.loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openMatchDetails(for: indexPath)
    }
}
