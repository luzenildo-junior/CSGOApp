//
//  HomeViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import Combine
import CSGOTVNetworking

final class HomeViewModel {
    @Published var viewState: HomeState = .loading
    private let service: HomeService
    private let matchesManager = MatchesManager()
    private var matchesDisplayableElements = [MatchesDisplayableContent]()
    
    private var page = 1
    
    init(service: HomeService = HomeService(service: CSGOServiceAPI())) {
        self.service = service
    }
    
    func fetchTournamentData() {
        service.fetchTournaments(for: page) { result in
            switch result {
            case .success(let tournamentData):
                self.handleTournamentsData(data: tournamentData)
                self.viewState = .showMatches
            case .failure(let error):
                self.viewState = .showError(message: error.localizedDescription)
            }
        }
    }
    
    private func handleTournamentsData(data: [CSGOTournamentResponseModel]) {
        let parsedData = self.matchesManager.parseData(tournaments: data)
        self.matchesDisplayableElements.append(contentsOf: parsedData.sorted(by: {
            $0.status < $1.status
        }))
    }
    
    func getTableViewNumberOfRows() -> Int {
        matchesDisplayableElements.count
    }
    
    func getCellDisplayableContent(for indexPath: IndexPath) -> MatchesDisplayableContent {
        matchesDisplayableElements[indexPath.row]
    }
}

extension HomeViewModel {
    enum HomeState {
        case loading
        case showMatches
        case showError(message: String)
    }
}
