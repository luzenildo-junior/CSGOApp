//
//  LandingViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import UIKit
import Combine

final class LandingViewController: BaseViewController {
    var viewModel: LandingViewModel
    
    // MARK: View Elements
    lazy var fuzeLogo: UIImageView = {
        let logo = UIImage(named: "fuze-logo")
        return UIImageView(image: logo)
    }()
    
    // MARK: Variables
    private var cancellables = Set<AnyCancellable>()
    private let affineTransformationScale = 0.2
    
    // MARK: Lifecycle methods
    init(viewModel: LandingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableCodeView()
        subscribeToPublishers()
        viewModel.startCountdownToDismissView()
    }
    
    // MARK: Private methods
    private func subscribeToPublishers() {
        viewModel.$dismissView
            .sink { [weak self] shouldDismiss in
                if shouldDismiss {
                    self?.animatedDismiss()
                }
            }
            .store(in: &cancellables)
    }
    
    private func animatedDismiss() {
        UIView.animate(withDuration: AppConstraints.Animation.Duration.fast,
                       delay: 0.0,
                       options: .curveEaseInOut) {
            self.fuzeLogo.transform = CGAffineTransform(scaleX: self.affineTransformationScale,
                                                        y: self.affineTransformationScale)
            self.view.alpha = 0.0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}

// MARK: CodeView setup
extension LandingViewController: CodeView {
    func addViewHierarchy() {
        view.addSubview(fuzeLogo)
    }
    
    func setupConstraints() {
        fuzeLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fuzeLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fuzeLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fuzeLogo.widthAnchor.constraint(equalToConstant: AppConstraints.Image.landingLogoSize),
            fuzeLogo.heightAnchor.constraint(equalToConstant: AppConstraints.Image.landingLogoSize)
        ])
    }
    
    func configureViews() {
        view.accessibilityIdentifier = "landing-view"
        fuzeLogo.accessibilityIdentifier = "fuze-logo"
    }
}
