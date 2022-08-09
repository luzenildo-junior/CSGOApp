//
//  CSGOTournamentResponseModelTests.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 08/08/22.
//

import XCTest
@testable import CSGOTVNetworking

final class CSGOTournamentResponseModelTests: XCTestCase {
    func test_tournamentResponseParse() {
        let expectedResult = CSGOTournamentResponse.mock
        let parsedData: [CSGOTournamentResponse] = "TournamentResponse".decodeJSONFromFileName()
        let sut = parsedData[0]
        
        XCTAssertNotNil(parsedData)
        XCTAssertEqual(sut.league, expectedResult.league)
        XCTAssertEqual(sut.matches.count, 1)
        XCTAssertEqual(sut.matches, expectedResult.matches)
        XCTAssertEqual(sut.teams.count, 1)
        XCTAssertEqual(sut.teams, expectedResult.teams)
        XCTAssertEqual(sut.serie, expectedResult.serie)
    }
}
