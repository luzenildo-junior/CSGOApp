//
//  MatchDetailsViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import UIKit

final class MatchDetailsViewController: BaseViewController {
    private let viewModel: MatchDetailsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        // AccessibilityIdentifier for UITesting
        tableView.accessibilityIdentifier = "tableView"
        return tableView
    }()
    
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
    }
}

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
    }
}

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
