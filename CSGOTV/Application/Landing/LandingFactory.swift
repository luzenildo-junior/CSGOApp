//
//  LandingFactory.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import UIKit

final class LandingFactory {
    static func make() -> UIViewController {
        let viewModel = LandingViewModel()
        let viewController = LandingViewController(viewModel: viewModel)
        return viewController
    }
}
