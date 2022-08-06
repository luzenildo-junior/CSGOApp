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
    
    private lazy var matchDate = MatchDateView()
    
    private lazy var matchOpponents = MatchOpponentsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(codser:) has not been implemented")
    }
    
    func setupMatchCell(with content: MatchesDisplayableContent) {
        matchDate.setupMatchDateView(matchDate: content.Date, isMatchRunning: content.status == .running)
        matchOpponents.setupOpponentsView(with: content.team1, team2: content.team2)
    }
}

extension MatchTableViewCell: CodeView {
    func addViewHierarchy() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(matchDate)
        cellBackgroundView.addSubview(matchOpponents)
    }
    
    func setupConstraints() {
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        matchDate.translatesAutoresizingMaskIntoConstraints = false
        matchOpponents.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // cell background view
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            
            // match date
            matchDate.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
            matchDate.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor),
            matchDate.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            matchDate.bottomAnchor.constraint(equalTo: matchOpponents.topAnchor, constant: -16.0),
            
            // match opponents
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
