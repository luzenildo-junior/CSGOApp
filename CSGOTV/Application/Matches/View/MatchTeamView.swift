//
//  MatchTeamView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import UIKit
import CSGOTVNetworking
import Kingfisher

final class MatchTeamView: UIView {
    private lazy var teamImage = UIImageView()
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFonts.Label.robotoMedium
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var viewsStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [teamImage, teamName])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTeamView(with team: CSGOTeam) {
        teamName.text = team.name
        if let teamImageURL = team.imageUrl {
            teamImage.kf.setImage(
                with: URL(string: teamImageURL),
                placeholder: UIImage(named: "team-logo-placeholder")
            )
        } else {
            teamImage.image = UIImage(named: "no-team-logo")
            teamImage.tintColor = AppColors.lightGray
        }
    }
}

extension MatchTeamView: CodeView {
    func addViewHierarchy() {
        addSubview(viewsStack)
    }
    
    func setupConstraints() {
        viewsStack.translatesAutoresizingMaskIntoConstraints = false
        teamImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // stack view
            viewsStack.topAnchor.constraint(equalTo: self.topAnchor),
            viewsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            // team image
            teamImage.widthAnchor.constraint(equalToConstant: AppConstraints.Image.small),
            teamImage.heightAnchor.constraint(equalToConstant: AppConstraints.Image.small),
            teamName.widthAnchor.constraint(equalToConstant: AppConstraints.Image.small).withPriority(100)
        ])
    }
}
