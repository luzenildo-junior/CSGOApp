//
//  MatchDetailsViewModelTests.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import XCTest
@testable import CSGOTV
import CSGOTVNetworking
import Combine

final class MatchDetailsServiceMock: MatchDetailsServiceProtocol {
    var result: Result<[[CSGOTeam]], Error>?
    var teams = [CSGOTeam]()
    
    var didFetchTeamPlayers = false
    
    func fetchTeamPlayers(teams: [CSGOTeam], completion: @escaping (Result<[[CSGOTeam]], Error>) -> ()) {
        self.teams = teams
        didFetchTeamPlayers = true
        
        guard let result = result else {
            return
        }
        completion(result)
    }
}

class MatchDetailsViewModelTests: XCTestCase {
    private var service: MatchDetailsServiceMock!
    private var viewModel: MatchDetailsViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        service = MatchDetailsServiceMock()
        viewModel = MatchDetailsViewModel(
            match: MatchDisplayableContent.mock,
            service: service
        )
    }
    
    func test_viewTitle() {
        let title = viewModel.viewTitle
        
        XCTAssertEqual(title, "match-name")
    }
    
    func test_getMatchDetailsHeaderContent() {
        let matchDetails = viewModel.getMatchDetailsHeaderContent()
        
        XCTAssertEqual(matchDetails.team1, CSGOTeam.mock)
        XCTAssertEqual(matchDetails.team2, CSGOTeam.mock)
        XCTAssertEqual(matchDetails.date, MatchDateParser(with: Date()).toString())
    }
    
    func test_fetchTeamPlayers() {
        service.result = .success([[CSGOTeam.mock]])
        
        let expectation = expectation(description: "expected to parse the data")
        
        viewModel.fetchTeamPlayers()
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                case .displayPlayers:
                    expectation.fulfill()
                default:
                    XCTFail("Should not be here")
                }
            }
            .store(in: &cancellables)
        
        
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertTrue(service.didFetchTeamPlayers)
        XCTAssertEqual(service.teams, [CSGOTeam.mock, CSGOTeam.mock])
        XCTAssertEqual(viewModel.getNumberOfRows(), 1)
    }
    
    func test_getNumberOfRows() {
        service.result = .success([[CSGOTeam.mock]])
        
        viewModel.fetchTeamPlayers()
        let numberOfRows = viewModel.getNumberOfRows()
        
        XCTAssertEqual(numberOfRows, 1)
    }
    
    func test_getPlayers() {
        service.result = .success([[CSGOTeam.mock]])
        
        viewModel.fetchTeamPlayers()
        let players = viewModel.getPlayers(for: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(players.player1, CSGOPlayer.mock)
        XCTAssertEqual(players.player2, CSGOPlayer.mock)
    }
}
