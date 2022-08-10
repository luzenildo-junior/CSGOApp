//
//  MatchesServiceTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import CSGOTVNetworking
import Combine
import XCTest
@testable import CSGOTV

enum APINetworkingMockErrors: Error {
    case PromiseNullError
}

final class TournamentSessionMock: CSGOTournamentSession {
    var promiseFuture: Future<[CSGOTournamentResponse], Error>?
    var requestPage = 0
    var didGetTournament = false
    
    func getTournament(page: Int) -> Future<[CSGOTournamentResponse], Error> {
        requestPage = page
        didGetTournament = true
        guard let promiseFuture = promiseFuture else {
            return Future { $0(.failure(APINetworkingMockErrors.PromiseNullError))}
        }
        return promiseFuture
    }
}

class MatchesServiceTests: XCTestCase {
    var sessionMock: TournamentSessionMock!
    var service: MatchesService!

    override func setUp() {
        super.setUp()
        sessionMock = TournamentSessionMock()
        service = MatchesService(service: sessionMock)
    }

    func test_fetchTournaments_whenSuccess() {
        let expectedResult: [CSGOTournamentResponse] = "TournamentResponse".decodeJSONFromFileName()
        sessionMock.promiseFuture = Future { $0(.success(expectedResult))}
        let expectation = expectation(description: "expected to parse the data")
        
        service.fetchTournaments(for: 1) { result in
            switch result {
            case .success(let responseData):
                XCTAssertEqual(responseData, expectedResult)
                expectation.fulfill()
            case .failure:
                XCTFail("Should not be here")
            }
        }
        
        waitForExpectations(timeout: 5.0)
        XCTAssertTrue(sessionMock.didGetTournament)
        XCTAssertEqual(sessionMock.requestPage, 1)
    }
    
    func test_fetchTournaments_whenFails() {
        let expectation = expectation(description: "expected to parse the data")
        
        service.fetchTournaments(for: 1) { result in
            switch result {
            case .failure(let error):
                XCTAssert(error is APINetworkingMockErrors)
                expectation.fulfill()
            case .success:
                XCTFail("Should not be here")
            }
        }
        
        waitForExpectations(timeout: 5.0)
        XCTAssertTrue(sessionMock.didGetTournament)
        XCTAssertEqual(sessionMock.requestPage, 1)
    }
}
