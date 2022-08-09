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
    lazy var fuseLogo: UIImageView = {
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
            self.fuseLogo.transform = CGAffineTransform(scaleX: self.affineTransformationScale,
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
        view.addSubview(fuseLogo)
    }
    
    func setupConstraints() {
        fuseLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fuseLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fuseLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fuseLogo.widthAnchor.constraint(equalToConstant: AppConstraints.Image.landingLogoSize),
            fuseLogo.heightAnchor.constraint(equalToConstant: AppConstraints.Image.landingLogoSize)
        ])
    }
}
