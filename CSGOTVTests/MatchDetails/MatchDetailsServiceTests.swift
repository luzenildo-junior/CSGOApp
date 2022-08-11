//
//  MatchDetailsServiceTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import CSGOTVNetworking
import Combine
import XCTest
@testable import CSGOTV

final class TeamsSessionMock: CSGOTeamSession {
    var promiseFuture: Future<[[CSGOTeam]], Error>?
    var requestTeamsIds = [Int64]()
    var didGetTeams = false
    
    func getTeam(with ids: [Int64]) -> Future<[[CSGOTeam]], Error> {
        requestTeamsIds = ids
        didGetTeams = true
        guard let promiseFuture = promiseFuture else {
            return Future { $0(.failure(APINetworkingMockErrors.PromiseNullError))}
        }
        return promiseFuture
    }
}

class MatchDetailsServiceTests: XCTestCase {
    var sessionMock: TeamsSessionMock!
    var service: MatchDetailsService!

    override func setUp() {
        super.setUp()
        sessionMock = TeamsSessionMock()
        service = MatchDetailsService(service: sessionMock)
    }

    func test_fetchTournaments_whenSuccess() {
        let expectedResult: CSGOTeam = CSGOTeam(id: 123456, name: "team-name")
        sessionMock.promiseFuture = Future { $0(.success([[expectedResult]]))}
        let expectation = expectation(description: "expected to parse the data")
        
        service.fetchTeamsInformations(teams: [expectedResult]) { result in
            switch result {
            case .success(let responseData):
                XCTAssertEqual(responseData, [[expectedResult]])
                expectation.fulfill()
            case .failure:
                XCTFail("Should not be here")
            }
        }
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertTrue(sessionMock.didGetTeams)
        XCTAssertEqual(sessionMock.requestTeamsIds, [123456])
    }
    
    func test_fetchTournaments_whenFails() {
        let expectation = expectation(description: "expected to parse the data")
        let expectedResult: CSGOTeam = CSGOTeam(id: 123456, name: "team-name")
        
        service.fetchTeamsInformations(teams: [expectedResult]) { result in
            switch result {
            case .failure(let error):
                XCTAssert(error is APINetworkingMockErrors)
                expectation.fulfill()
            case .success:
                XCTFail("Should not be here")
            }
        }
        
        waitForExpectations(timeout: 5.0)
        XCTAssertTrue(sessionMock.didGetTeams)
        XCTAssertEqual(sessionMock.requestTeamsIds, [123456])
    }
}
