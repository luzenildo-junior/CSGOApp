//
//  MainCoordinator.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeView()
        showLandingView()
    }
    
    private func showLandingView() {
        let landingViewController = LandingFactory.make()
        landingViewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(landingViewController, animated: false)
    }
    
    private func showHomeView() {
        let matchesCoordinator = MatchesCoordinator(navigationController: navigationController)
        matchesCoordinator.start()
        childCoordinators.append(matchesCoordinator)
    }
}
