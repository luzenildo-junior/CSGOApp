//
//  CSGOLeagueTests.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import XCTest
@testable import CSGOTVNetworking

final class CSGOLeagueTests: XCTestCase {
    func test_leagueParse() {
        let jsonString =
            """
                {
                    "name": "league-name",
                    "image_url": "http://image.url"
                }
            """
        let sut: CSGOLeague = jsonString.decodeJSONString()
        
        XCTAssertEqual(sut.name, "league-name")
        XCTAssertNotNil(sut.imageUrl)
        XCTAssertEqual(sut.imageUrl, "http://image.url")
    }
}
