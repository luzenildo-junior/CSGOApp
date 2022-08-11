//
//  MatchDetailsViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import UIKit
import Combine

final class MatchDetailsViewController: BaseViewController {
    private let viewModel: MatchDetailsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: View elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(type: MatchDetailsPlayerCell.self)
        tableView.accessibilityIdentifier = "match-details-tableView"
        return tableView
    }()
    
    // MARK: Lifecycle methods
    init(viewModel: MatchDetailsViewModel) {
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
    }
    
    // MARK: Private methods
    private func subscribeToPublishers() {
        viewModel.$viewState
        .receive(on: DispatchQueue.main)
        .sink { [weak self] viewState in
            guard let self = self else { return }
            switch viewState {
            case .loading:
                self.startLoading()
            case .displayPlayers:
                self.stopLoading()
                self.tableView.reloadData()
            case .showError(let message):
                self.showAlert(message: message) { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.fetchTeamPlayers()
                }
            }
        }.store(in: &cancellables)
    }
}

// MARK: CodeView setup
extension MatchDetailsViewController: CodeView {
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
        setBackButton()
        title = viewModel.viewTitle
        navigationItem.largeTitleDisplayMode = .never
        tableView.backgroundColor = .clear
        viewModel.fetchTeamPlayers()
        view.accessibilityIdentifier = "match-details-view"
    }
}

// MARK: UITableViewDataSource setup
extension MatchDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(for: MatchDetailsPlayerCell.self, indexPath: indexPath) else { return UITableViewCell() }
        let players = viewModel.getPlayers(for: indexPath)
        cell.setupMatchDetailsPlayerCell(with: players.player1, player2: players.player2)
        return cell
    }
}

// MARK: UITableViewDelegate setup
extension MatchDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MatchDetailsTableViewHeader()
        let headerContent = viewModel.getMatchDetailsHeaderContent()
        view.setupMatchDetailsTableViewHeader(
            teams: (headerContent.0, headerContent.1),
            date: headerContent.date
        )
        return view
    }
}
