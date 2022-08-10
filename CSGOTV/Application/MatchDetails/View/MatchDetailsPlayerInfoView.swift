//
//  MatchDetailsPlayerInfoView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
import UIKit
import CSGOTVNetworking

final class MatchDetailsPlayerInfoView: UIView {
    enum PlayerInfoViewStyle {
        case left
        case right
    }
    
    private lazy var playerInfoBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.matchCellBackgroundColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var playerNickname: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFonts.Label.robotoLarge
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.fontGray
        label.font = AppFonts.Label.robotoMedium
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var playerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColors.lightGray
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMatchDetailsPlayerInfoView(with player: CSGOPlayer, playerViewStyle: PlayerInfoViewStyle) {
        playerNickname.text = player.name
        playerName.text = player.firstName
        if let playerImageURL = player.imageUrl {
            playerImage.kf.setImage(
                with: URL(string: playerImageURL)
            )
        } else {
            playerImage.image = nil
        }
        setupStyleConstraints(viewStyle: playerViewStyle)
    }
}

extension MatchDetailsPlayerInfoView: CodeView {
    func addViewHierarchy() {
        addSubview(playerInfoBackground)
        [playerNickname, playerName, playerImage].forEach {
            playerInfoBackground.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        playerInfoBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerInfoBackground.topAnchor.constraint(equalTo: self.topAnchor),
            playerInfoBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playerInfoBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            playerInfoBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            playerImage.topAnchor.constraint(equalTo: playerInfoBackground.topAnchor, constant: -2.0),
            playerImage.heightAnchor.constraint(equalToConstant: 60.0),
            playerImage.widthAnchor.constraint(equalToConstant: 60.0),
            playerImage.bottomAnchor.constraint(equalTo: playerInfoBackground.bottomAnchor, constant: -8.0).withPriority(100.0),
            
            playerNickname.centerYAnchor.constraint(equalTo: playerImage.centerYAnchor),
            
            playerName.topAnchor.constraint(equalTo: playerNickname.bottomAnchor, constant: 2.0),
        ])
    }
    
    private func setupStyleConstraints(viewStyle: PlayerInfoViewStyle) {
        switch viewStyle {
        case .left:
            NSLayoutConstraint.activate([
                playerImage.trailingAnchor.constraint(equalTo: playerInfoBackground.trailingAnchor, constant: -12.0),
                playerNickname.trailingAnchor.constraint(equalTo: playerImage.leadingAnchor, constant: -16.0),
                playerName.trailingAnchor.constraint(equalTo: playerNickname.trailingAnchor)
            ])
            playerInfoBackground.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .right:
            NSLayoutConstraint.activate([
                playerImage.leadingAnchor.constraint(equalTo: playerInfoBackground.leadingAnchor, constant: 12.0),
                playerNickname.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 16.0),
                playerName.leadingAnchor.constraint(equalTo: playerNickname.leadingAnchor)
            ])
            
            playerInfoBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
}
