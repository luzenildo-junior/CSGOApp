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
    
    init(service: HomeService = HomeService(service: CSGOServiceAPI())) {
        self.service = service
    }
    
    func fetchTournamentData() {
        service.fetchTournaments(with: 1) { result in
            switch result {
            case .success(let tournamentData):
                self.matchesDisplayableElements.append(contentsOf: self.matchesManager.parseData(tournaments: tournamentData))
                self.viewState = .showMatches
            case .failure(let error):
                self.viewState = .showError(message: error.localizedDescription)
            }
        }
    }
}

extension HomeViewModel {
    enum HomeState {
        case loading
        case showMatches
        case showError(message: String)
    }
}
