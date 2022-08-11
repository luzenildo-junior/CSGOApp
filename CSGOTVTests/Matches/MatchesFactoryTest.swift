//
//  MatchesFactoryTest.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV

final class MatchesFactoryTest: XCTestCase {
    func test_make() {
        let makeReturn = MatchesFactory.make(coordinatorDelegate: MatchesCoordinatorDelegateMock())
        
        XCTAssertTrue(makeReturn is MatchesViewController)
    }
}
