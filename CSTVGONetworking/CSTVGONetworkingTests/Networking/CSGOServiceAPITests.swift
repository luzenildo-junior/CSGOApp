//
//  CSGONetworkingAPITests.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import XCTest
import Combine
@testable import CSGOTVNetworking

final class CSGOServiceAPITests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func test_getTournament() throws {
        let mockedAPI = NetworkingAPIMock<CSGOTournamentResponse>()
        mockedAPI.jsonMockedValue = "TournamentResponse".getJsonString()
        let serviceAPI = CSGOServiceAPI(networkingAPI: mockedAPI)
        let expectation = expectation(description: "expected to run code")
        
        serviceAPI.getTournament(page: 0).sink { promiseCompletion in
            switch promiseCompletion {
            case .failure:
                XCTFail("Shouldn't come here")
            case .finished:
                break
            }
        } receiveValue: { tournament in
            XCTAssertNotNil(tournament)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        let apiConfiguration = mockedAPI.urlConvertibleData as? APIRequestConfiguration
        XCTAssertNotNil(apiConfiguration)
        XCTAssertEqual(apiConfiguration?.method, .get)
        XCTAssertEqual(apiConfiguration?.path, "/tournaments")
        
        switch apiConfiguration?.parameters {
        case .queryItems(let items):
            let page = try XCTUnwrap(items["page"] as? Int)
            XCTAssertEqual(page, 0)
            let perPage = try XCTUnwrap(items["per_page"] as? Int)
            XCTAssertEqual(perPage, 5)
            let sort = try XCTUnwrap(items["sort"] as? String)
            XCTAssertEqual(sort, "begin_at")
        default:
            XCTFail("Should not be here")
        }
    }
    
    func test_getTeams() throws {
        let mockedAPI = NetworkingAPIMock<[[CSGOTeam]]>()
        mockedAPI.jsonMockedValue = "TeamResponse".getJsonString()
        let serviceAPI = CSGOServiceAPI(networkingAPI: mockedAPI)
        let expectation = expectation(description: "expected to parse the json")
        
        serviceAPI.getTeam(with: [123456]).sink{ promiseCompletion in
            switch promiseCompletion {
            case .failure:
                XCTFail("Shouldn't come here")
            case .finished:
                break
            }
        } receiveValue: { team in
            XCTAssertNotNil(team)
            XCTAssertEqual(team.count, 1)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        let apiConfiguration = mockedAPI.urlConvertibleData as? APIRequestConfiguration
        XCTAssertNotNil(apiConfiguration)
        XCTAssertEqual(apiConfiguration?.method, .get)
        XCTAssertEqual(apiConfiguration?.path, "/teams")
        
        switch apiConfiguration?.parameters {
        case .queryItems(let items):
            let teamId = try XCTUnwrap(items["filter[id]"] as? Int64)
            XCTAssertEqual(teamId, 123456)
        default:
            XCTFail("Should not be here")
        }
    }
}
