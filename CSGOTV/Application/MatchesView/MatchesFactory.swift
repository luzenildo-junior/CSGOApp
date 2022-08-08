//
//  HomeViewFactory.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import CSGOTVNetworking
import Foundation
import UIKit

final class MatchesFactory {
    static func make(coordinatorDelegate: MatchesCoordinatorDelegate) -> UIViewController {
        let service = MatchesService(service: CSGOServiceAPI())
        let viewModel = MatchesViewModel(service: service, coordinatorDelegate: coordinatorDelegate)
        let viewController = MatchesViewController(viewModel: viewModel)
        return viewController
    }
}
