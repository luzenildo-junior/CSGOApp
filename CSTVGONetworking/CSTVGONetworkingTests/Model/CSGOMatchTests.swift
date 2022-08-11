//
//  CSGO.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import XCTest
@testable import CSGOTVNetworking

final class CSGOMatchTests: XCTestCase {
    func test_matchParse() {
        let jsonString =
            """
                {
                    "begin_at": "2022-10-02T13:00:00Z",
                    "id": 645212,
                    "name": "match-name",
                    "status": "not_started"
                }
            """
        let sut: CSGOMatch = jsonString.decodeJSONString()
        
        XCTAssertEqual(sut.beginAt, "2022-10-02T13:00:00Z")
        XCTAssertEqual(sut.id, 645212)
        XCTAssertEqual(sut.name, "match-name")
        XCTAssertEqual(sut.status, .notStarted)
    }
}
