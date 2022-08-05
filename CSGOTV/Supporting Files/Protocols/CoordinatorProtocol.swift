//
//  CoordinatorProtocol.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
