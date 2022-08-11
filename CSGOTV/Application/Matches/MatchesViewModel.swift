//
//  HomeViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import Combine
import CSGOTVNetworking

final class MatchesViewModel {
    @Published var viewState: HomeState = .loading
    private let service: MatchesServiceProtocol
    private weak var coordinatorDelegate: MatchesCoordinatorDelegate?
    private let matchesManager = MatchesManager()
    private var matchDisplayableElements = [MatchDisplayableContent]()
    
    private var page = 1
    /// Flag to indicate that the last backend call returned empty, so it hits the last page.
    private var isLastPage = false
    private var isLoadingMoreData = false
    
    init(
        service: MatchesServiceProtocol,
        coordinatorDelegate: MatchesCoordinatorDelegate
    ) {
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func fetchTournamentData() {
        service.fetchTournaments(for: page) { result in
            switch result {
            case .success(let tournamentData):
                self.isLastPage = tournamentData.isEmpty
                self.handleTournamentsData(data: tournamentData)
            case .failure(let error):
                self.viewState = .showError(message: error.localizedDescription)
            }
        }
    }
    
    /// Method to load more data for pagination
    func loadMoreData() {
        // Locking the access to fetch tournament using isLoadingMoreData and isLastPage flags
        if !isLoadingMoreData && !isLastPage {
            viewState = .loading
            isLoadingMoreData = true
            page += 1
            fetchTournamentData()
        }
    }
    
    func getTableViewNumberOfRows() -> Int {
        matchDisplayableElements.count
    }
    
    func getCellDisplayableContent(for indexPath: IndexPath) -> MatchDisplayableContent {
        matchDisplayableElements[indexPath.row]
    }
    
    func openMatchDetails(for index: IndexPath) {
        let match = matchDisplayableElements[index.row]
        coordinatorDelegate?.openMatchDetails(match)
    }
    
    /// Handles tournaments data received from the backend
    private func handleTournamentsData(data: [CSGOTournamentResponse]) {
        // After fetchTournament backend call, I handle the tournament data received in this method.
        // Basically I'm sending it to a matches manager (see matchesManager class documentation) and sorting it first by date to get the closer dates first
        // and then sorting it by status to get the running ones first in the list
        self.matchDisplayableElements.append(contentsOf: self.matchesManager.parseData(tournaments: data))
        self.matchDisplayableElements = matchDisplayableElements
            .sorted(by: { $0.date < $1.date })
            .sorted(by: { $0.status < $1.status })
        self.viewState = .displayMatches
        self.isLoadingMoreData = false
    }
}

extension MatchesViewModel {
    enum HomeState {
        case loading
        case displayMatches
        case showError(message: String)
    }
}
