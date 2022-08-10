//
//  MatchesCoordinatorTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV
import CSGOTVNetworking

extension MatchDisplayableContent {
    static var mock: MatchDisplayableContent {
        MatchDisplayableContent(matchName: "match-name",
                                leagueImageUrl: nil,
                                team1: CSGOTeam(id: 1234567, name: "team-name"),
                                team2: CSGOTeam(id: 1234567, name: "team-name"),
                                status: .notStarted,
                                date: Date())
    }
}

final class UINavigationControllerMock: UINavigationController {
    var pushedViewController: UIViewController?
    
    var didTriedToPushViewController = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        didTriedToPushViewController = true
    }
}

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
