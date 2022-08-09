//
//  CSGOTeamTests.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation

import XCTest
@testable import CSGOTVNetworking

final class CSGOTeamTests: XCTestCase {
    func test_teamParse() {
        let jsonString =
            """
                {
                    "id": 12345678,
                    "name": "team-name"
                }
            """
        let sut: CSGOTeam = jsonString.decodeJSONString()
        
        XCTAssertEqual(sut.id, 12345678)
        XCTAssertEqual(sut.name, "team-name")
    }
}
