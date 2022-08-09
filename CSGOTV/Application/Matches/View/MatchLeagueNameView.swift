//
//  MatchLeagueNameView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import UIKit

final class MatchLeagueNameView: UIView {
    private lazy var leagueImage = UIImageView()
    
    private lazy var leagueName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = AppFonts.Label.robotoSmall
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        enableCodeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMatchLeagueNameView(with leagueName: String, leagueImageUrl: String?) {
        self.leagueName.text = leagueName
        if let imageUrl = leagueImageUrl {
            leagueImage.kf.setImage(
                with: URL(string: imageUrl),
                placeholder: UIImage(named: "team-logo-placeholder")
            )
        } else {
            leagueImage.image = UIImage(named: "team-logo-placeholder")
        }
    }
}
    
extension MatchLeagueNameView: CodeView {
    func addViewHierarchy() {
        addSubview(leagueImage)
        addSubview(leagueName)
    }
    
    func setupConstraints() {
        leagueImage.translatesAutoresizingMaskIntoConstraints = false
        leagueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // date view
            leagueImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            leagueImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            leagueImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
            leagueImage.widthAnchor.constraint(equalToConstant: AppConstraints.Image.xSmall),
            leagueImage.heightAnchor.constraint(equalToConstant: AppConstraints.Image.xSmall),
            // date label
            leagueName.centerYAnchor.constraint(equalTo: leagueImage.centerYAnchor),
            leagueName.leadingAnchor.constraint(equalTo: leagueImage.trailingAnchor, constant: 8.0),
            leagueName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
    }
}

