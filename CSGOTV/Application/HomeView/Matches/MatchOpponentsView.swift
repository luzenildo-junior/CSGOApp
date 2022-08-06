//
//  MatchOpponentsView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation
import UIKit
import CSGOTVNetworking

final class MatchOpponentsView: UIView {
    private lazy var team1View = MatchTeamView()
    private lazy var team2View = MatchTeamView()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.5)
        label.text = "vs"
        label.textAlignment = .center
        label.font = AppFonts.Label.robotoMedium
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupOpponentsView(with team1: CSGOTeam, team2: CSGOTeam) {
        team1View.setupTeamView(with: team1)
        team2View.setupTeamView(with: team2)
    }
}

extension MatchOpponentsView: CodeView {
    func addViewHierarchy() {
        [versusLabel, team1View, team2View].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        team1View.translatesAutoresizingMaskIntoConstraints = false
        team2View.translatesAutoresizingMaskIntoConstraints = false
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // team1
            team1View.topAnchor.constraint(equalTo: self.topAnchor),
            team1View.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            team1View.trailingAnchor.constraint(equalTo: versusLabel.leadingAnchor, constant: -20.0),
            // team2
            team2View.topAnchor.constraint(equalTo: team1View.topAnchor),
            team2View.bottomAnchor.constraint(equalTo: team1View.bottomAnchor),
            team2View.leadingAnchor.constraint(equalTo: versusLabel.trailingAnchor, constant: 20.0),
            // versus label
            versusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            versusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}


