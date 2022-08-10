//
//  MatchDetailsPlayerCell.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
import UIKit
import CSGOTVNetworking

final class MatchDetailsPlayerCell: UITableViewCell {
    private lazy var player1Info = MatchDetailsPlayerInfoView()
    private lazy var player2Info = MatchDetailsPlayerInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(codser:) has not been implemented")
    }
    
    func setupMatchDetailsPlayerCell(with player1: CSGOPlayer?, player2: CSGOPlayer?) {
        if let player1 = player1 {
            player1Info.isHidden = false
            player1Info.setupMatchDetailsPlayerInfoView(with: player1, playerViewStyle: .left)
        } else {
            player1Info.isHidden = true
        }
        
        if let player2 = player2 {
            player2Info.isHidden = false
            player2Info.setupMatchDetailsPlayerInfoView(with: player2, playerViewStyle: .right)
        } else {
            player2Info.isHidden = true
        }
    }
}

extension MatchDetailsPlayerCell: CodeView {
    func addViewHierarchy() {
        [player1Info, player2Info].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            player1Info.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            player1Info.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            player1Info.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -6.0),
            player1Info.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
            
            player2Info.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            player2Info.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 6.0),
            player2Info.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            player2Info.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
        ])
    }
    
    func configureViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
}
