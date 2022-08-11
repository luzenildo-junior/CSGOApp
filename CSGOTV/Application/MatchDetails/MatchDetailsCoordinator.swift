//
//  MatchDetailsCoordinator.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import UIKit

final class MatchDetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// can't use unavailable because its a requisite for Coordinator protocol (one of the problems of using protocols)
    @available(*, deprecated, message: "Please use start(with)")
    func start() { }
    
    func start(with match: MatchDisplayableContent) {
        navigationController.pushViewController(MatchDetailsFactory.make(with: match), animated: true)
    }
}
