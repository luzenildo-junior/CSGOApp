//
//  MatchesViewModelTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
import CSGOTVNetworking
import Combine
@testable import CSGOTV

final class MatchesServiceMock: MatchesServiceProtocol {
    var result: Result<[CSGOTournamentResponse], Error>?
    var page = 0
    
    var didFetchTournamentCount = 0
    
    func fetchTournaments(for page: Int, completion: @escaping (Result<[CSGOTournamentResponse], Error>) -> ()) {
        self.page = page
        didFetchTournamentCount += 1
        
        guard let result = result else {
            return
        }
        completion(result)
    }
}

final class MatchesCoordinatorDelegateMock: MatchesCoordinatorDelegate {
    var match: MatchDisplayableContent?
    
    var didOpenMatchDetails = false
    
    func openMatchDetails(_ match: MatchDisplayableContent) {
        self.match = match
        didOpenMatchDetails = true
    }
}

final class MatchesViewModelTests: XCTestCase {
    private var viewModel: MatchesViewModel!
    private var service: MatchesServiceMock!
    private var coordinatorDelegate: MatchesCoordinatorDelegateMock!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        service = MatchesServiceMock()
        coordinatorDelegate = MatchesCoordinatorDelegateMock()
        viewModel = MatchesViewModel(
            service: service,
            coordinatorDelegate: coordinatorDelegate
        )
    }
    
    func test_fetchTournamentData() {
        service.result = .success("TournamentResponse".decodeJSONFromFileName())
        let expectation = expectation(description: "expected to parse the data")
        
        viewModel.fetchTournamentData()
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .displayMatches:
                    expectation.fulfill()
                default:
                    XCTFail("Should not be here")
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertEqual(service.page, 1)
        XCTAssertEqual(service.didFetchTournamentCount, 1)
        XCTAssertEqual(viewModel.getTableViewNumberOfRows(), 1)
    }
    
    func test_loadMoreData() {
        service.result = .success("TournamentResponse".decodeJSONFromFileName())
        let expectation = expectation(description: "expected to parse the data")
        
        viewModel.fetchTournamentData()
        viewModel.loadMoreData()
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .displayMatches:
                    expectation.fulfill()
                default:
                    XCTFail("Should not be here")
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertEqual(service.page, 2)
        XCTAssertEqual(service.didFetchTournamentCount, 2)
        XCTAssertEqual(viewModel.getTableViewNumberOfRows(), 2)
    }
    
    func test_getTableViewNumberOfRows() {
        service.result = .success("TournamentResponse".decodeJSONFromFileName())
        
        viewModel.fetchTournamentData()
        let numberOfRows = viewModel.getTableViewNumberOfRows()
        
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func test_getCellDisplayableContent() {
        service.result = .success("TournamentResponse".decodeJSONFromFileName())
        
        viewModel.fetchTournamentData()
        let cellDisplayableContent = viewModel.getCellDisplayableContent(for: IndexPath(item: 0, section: 0))
        
        XCTAssertEqual(cellDisplayableContent.matchName, "league-name - serie-name")
        XCTAssertEqual(cellDisplayableContent.status, .notStarted)
        XCTAssertEqual(cellDisplayableContent.team1.name, "team-name")
        XCTAssertEqual(cellDisplayableContent.team2.name, "team-name")
    }
    
    func test_openMatchDetails() {
        service.result = .success("TournamentResponse".decodeJSONFromFileName())
        
        viewModel.fetchTournamentData()
        viewModel.openMatchDetails(for: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(coordinatorDelegate.didOpenMatchDetails)
        XCTAssertEqual(coordinatorDelegate.match?.matchName, "league-name - serie-name")
        XCTAssertEqual(coordinatorDelegate.match?.status, .notStarted)
        XCTAssertEqual(coordinatorDelegate.match?.team1.name, "team-name")
        XCTAssertEqual(coordinatorDelegate.match?.team2.name, "team-name")
    }
}
