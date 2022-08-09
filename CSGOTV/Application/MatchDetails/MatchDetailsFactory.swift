//
//  MatchDetailsFactory.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import CSGOTVNetworking
import Foundation
import UIKit

final class MatchDetailsFactory {
    static func make(with match: MatchDisplayableContent) -> UIViewController {
        let service = MatchDetailsService(service: CSGOServiceAPI())
        let viewModel = MatchDetailsViewModel(match: match, service: service)
        let viewController = MatchDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
