//
//  MatchDetailsTableViewHeader.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import Foundation
import UIKit
import CSGOTVNetworking

final class MatchDetailsTableViewHeader: UIView {
    private lazy var matchOpponents = MatchOpponentsView()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFonts.Label.robotoMedium
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMatchDetailsTableViewHeader(teams: (CSGOTeam, CSGOTeam), date: String) {
        matchOpponents.setupOpponentsView(with: teams.0, team2: teams.1)
        dateLabel.text = date
    }
}

extension MatchDetailsTableViewHeader: CodeView {
    func addViewHierarchy() {
        addSubview(matchOpponents)
        addSubview(dateLabel)
    }
    
    func setupConstraints() {
        matchOpponents.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // match opponents
            matchOpponents.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            matchOpponents.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            matchOpponents.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            
            // match date
            dateLabel.topAnchor.constraint(equalTo: matchOpponents.bottomAnchor, constant: 20.0),
            dateLabel.centerXAnchor.constraint(equalTo: matchOpponents.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
        ])
    }
}
