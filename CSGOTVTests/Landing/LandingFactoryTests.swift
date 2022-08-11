//
//  LandingFactoryTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV

final class LandingFactoryTest: XCTestCase {
    func test_make() {
        let makeReturn = LandingFactory.make()
        
        XCTAssertTrue(makeReturn is LandingViewController)
    }
}
