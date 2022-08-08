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
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        return view
    }()
    
    private lazy var matchLeagueName = MatchLeagueNameView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(codser:) has not been implemented")
    }
    
    func setupMatchCell(with content: MatchDisplayableContent) {
        matchDate.setupMatchDateView(matchDate: MatchDateParser(with: content.date).toString(),
                                     isMatchRunning: content.status == .running)
        matchOpponents.setupOpponentsView(with: content.team1, team2: content.team2)
        matchLeagueName.setupMatchLeagueNameView(with: content.matchName, leagueImageUrl: content.leagueImageUrl)
    }
}

extension MatchTableViewCell: CodeView {
    func addViewHierarchy() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(matchDate)
        cellBackgroundView.addSubview(matchOpponents)
        cellBackgroundView.addSubview(separator)
        cellBackgroundView.addSubview(matchLeagueName)
    }
    
    func setupConstraints() {
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        matchDate.translatesAutoresizingMaskIntoConstraints = false
        matchOpponents.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        matchLeagueName.translatesAutoresizingMaskIntoConstraints = false
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
            
            // separator
            separator.topAnchor.constraint(equalTo: matchOpponents.bottomAnchor, constant: 16.0),
            separator.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.0),
            
            // match league name
            matchLeagueName.topAnchor.constraint(equalTo: separator.bottomAnchor),
            matchLeagueName.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor),
            matchLeagueName.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor),
            matchLeagueName.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor)
        ])
    }
    
    func configureViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
}
