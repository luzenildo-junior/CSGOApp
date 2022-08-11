//
//  CSGOPlayerTests.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation

import XCTest
@testable import CSGOTVNetworking

final class CSGOPlayerTests: XCTestCase {
    func test_playerParse() {
        let jsonString =
            """
                {
                    "first_name": "player-first-name",
                    "last_name": "player-last-name",
                    "image_url": "http://image.url",
                    "name": "player-name"
                }
            """
        let sut: CSGOPlayer = jsonString.decodeJSONString()
        
        XCTAssertEqual(sut.firstName, "player-first-name")
        XCTAssertEqual(sut.lastName, "player-last-name")
        XCTAssertNotNil(sut.imageUrl)
        XCTAssertEqual(sut.imageUrl, "http://image.url")
        XCTAssertEqual(sut.name, "player-name")
    }
}
