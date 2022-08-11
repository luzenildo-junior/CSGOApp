//
//  MatchesCoordinatorTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV
import CSGOTVNetworking

class MatchesCoordinatorTests: XCTestCase {
    var navigationControllerMock: UINavigationControllerMock!
    var coordinator: MatchesCoordinator!

    override func setUp() {
        super.setUp()
        navigationControllerMock = UINavigationControllerMock()
        coordinator = MatchesCoordinator(navigationController: navigationControllerMock)
    }

    func test_startCoordinator() {
        coordinator.start()
        
        XCTAssertTrue(navigationControllerMock.didTriedToPushViewController)
        XCTAssert(navigationControllerMock.pushedViewController is MatchesViewController)
    }
    
    func test_openMatchDetails() {
        coordinator.openMatchDetails(MatchDisplayableContent.mock)
        
        XCTAssertTrue(navigationControllerMock.didTriedToPushViewController)
        XCTAssert(navigationControllerMock.pushedViewController is MatchDetailsViewController)
    }
}
