//
//  MatchesCoordinator.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import UIKit

protocol MatchesCoordinatorDelegate: AnyObject {
    func openMatchDetails(_ match: MatchDisplayableContent)
}

final class MatchesCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let matchesViewController = MatchesFactory.make(coordinatorDelegate: self)
        navigationController.pushViewController(matchesViewController, animated: false)
    }
    
}

extension MatchesCoordinator: MatchesCoordinatorDelegate {
    func openMatchDetails(_ match: MatchDisplayableContent) {
        
    }
}
