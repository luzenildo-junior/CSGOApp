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
    private let service: MatchesService
    private weak var coordinatorDelegate: MatchesCoordinatorDelegate?
    private let matchesManager = MatchesManager()
    private var matchDisplayableElements = [MatchDisplayableContent]()
    
    private var page = 1
    private var isLastPage = false
    private var isLoadingMoreData = false
    
    init(service: MatchesService, coordinatorDelegate: MatchesCoordinatorDelegate) {
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
    
    func loadMoreData() {
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
    
    private func handleTournamentsData(data: [CSGOTournamentResponseModel]) {
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
