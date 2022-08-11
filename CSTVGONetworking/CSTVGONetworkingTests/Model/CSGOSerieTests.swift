//
//  CSGOSerieTests.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 09/08/22.
//

import XCTest
@testable import CSGOTVNetworking

final class CSGOSerieTests: XCTestCase {
    func test_serieParse() {
        let jsonString =
            """
                {
                    "name": "serie-name"
                }
            """
        let sut: CSGOSerie = jsonString.decodeJSONString()
        
        XCTAssertNotNil(sut.name)
        XCTAssertEqual(sut.name, "serie-name")
    }
}
