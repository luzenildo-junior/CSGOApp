//
//  MatchTimeView.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 06/08/22.
//

import UIKit

final class MatchDateView: UIView {
    private lazy var dateView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
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
    
    func setupMatchDateView(matchDate: String, isMatchRunning: Bool) {
        if isMatchRunning {
            dateLabel.text = "AGORA"
            dateView.backgroundColor = .red
        } else {
            dateLabel.text = matchDate
            dateView.backgroundColor = AppColors.darkGray
        }
    }
}

extension MatchDateView: CodeView {
    
    func addViewHierarchy() {
        addSubview(dateView)
        dateView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // date view
            dateView.topAnchor.constraint(equalTo: self.topAnchor),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            // date label
            dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 8.0),
            dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor, constant: -8.0),
            dateLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 8.0),
            dateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -8.0)
        ])
    }
}
