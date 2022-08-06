//
//  MatchOpponentsView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import Foundation
import UIKit
import CSGOTVNetworking

typealias Spacing = UIView

final class MatchOpponentsView: UIView {
    private lazy var team1View = MatchTeamView()
    private lazy var team2View = MatchTeamView()
    
    private lazy var versusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 1.0, alpha: 0.5)
        label.text = "vs"
        label.textAlignment = .center
        label.font = AppFonts.Label.robotoSmall
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var viewsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            Spacing(),
            team1View,
            versusLabel,
            team2View,
            Spacing()
        ])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
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
        addSubview(viewsStack)
    }
    
    func setupConstraints() {
        viewsStack.translatesAutoresizingMaskIntoConstraints = false
        team1View.translatesAutoresizingMaskIntoConstraints = false
        team2View.translatesAutoresizingMaskIntoConstraints = false
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // stack view
            viewsStack.topAnchor.constraint(equalTo: self.topAnchor),
            viewsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


