//
//  MatchDetailsCoordinatorTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV
import CSGOTVNetworking

class MatchDetailsCoordinatorTests: XCTestCase {
    var navigationControllerMock: UINavigationControllerMock!
    var coordinator: MatchDetailsCoordinator!

    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        coordinator = MatchDetailsCoordinator(navigationController: navigationControllerMock)
    }

    func test_startCoordinatorWithDisplayableContent() {
        coordinator.start(with: MatchDisplayableContent.mock)
        
        XCTAssertTrue(navigationControllerMock.didTriedToPushViewController)
        XCTAssert(navigationControllerMock.pushedViewController is MatchDetailsViewController)
    }
}
