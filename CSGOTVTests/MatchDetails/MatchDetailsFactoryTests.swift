//
//  MatchDetailsFactoryTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV

final class MatchDetailsFactoryTest: XCTestCase {
    func test_make() {
        let makeReturn = MatchDetailsFactory.make(with: MatchDisplayableContent.mock)
        
        XCTAssertTrue(makeReturn is MatchDetailsViewController)
    }
}

