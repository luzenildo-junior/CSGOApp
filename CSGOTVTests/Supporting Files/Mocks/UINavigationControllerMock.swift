//
//  UINavigationControllerMock.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import UIKit

final class UINavigationControllerMock: UINavigationController {
    var pushedViewController: UIViewController?
    
    var didTriedToPushViewController = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        didTriedToPushViewController = true
    }
}
