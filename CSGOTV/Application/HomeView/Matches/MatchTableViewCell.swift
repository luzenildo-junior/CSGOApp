//
//  MatchTableViewCell.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation
import UIKit

final class MatchTableViewCell: UITableViewCell {
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.matchCellBackgroundColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var matchOpponents = MatchOpponentsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(codser:) has not been implemented")
    }
    
    func setupMatchCell(with content: MatchesDisplayableContent) {
        matchOpponents.setupOpponentsView(with: content.team1, team2: content.team2)
    }
}

extension MatchTableViewCell: CodeView {
    func addViewHierarchy() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(matchOpponents)
    }
    
    func setupConstraints() {
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        matchOpponents.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // tableView
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            matchOpponents.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            matchOpponents.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor),
            matchOpponents.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            matchOpponents.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor)
        ])
    }
    
    func configureViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
}
