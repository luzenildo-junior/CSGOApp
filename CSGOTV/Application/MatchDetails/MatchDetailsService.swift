//
//  MatchDetailsService.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import CSGOTVNetworking
import Combine
import Foundation

/// Service protocol created for testing purposes. It enables unit testing for either this service and mock the backend call for viewModels
protocol MatchDetailsServiceProtocol {
    func fetchTeamsInformations(
        teams: [CSGOTeam],
        completion: @escaping (Result<[[CSGOTeam]], Error>) -> ()
    )
}

final class MatchDetailsService {
    private var cancellables = Set<AnyCancellable>()
    let service: CSGOTeamSession
    
    init(service: CSGOTeamSession) {
        self.service = service
    }
}

extension MatchDetailsService: MatchDetailsServiceProtocol {
    /// Method to fetch team informations
    ///     - Parameters:
    ///         - teams: Array of CSGOTeams which you want the informations. These objects doesn't have the players info.
    ///         - completion: it can return a Array of Array of CSTOTeam containing all players info if succeeds, or error if fails
    /// as the tournament backend call do returns the team, but not the team players, I had to do a separate call to get team players information
    func fetchTeamsInformations(
        teams: [CSGOTeam],
        completion: @escaping (Result<[[CSGOTeam]], Error>) -> ()
    ) {
        let teamIds = teams.compactMap { $0.id }
        service.getTeam(with: teamIds)
            .receive(on: DispatchQueue.main)
            .sink { promiseCompletion in
                switch promiseCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { teams in
                completion(.success(teams))
            }.store(in: &cancellables)
    }
}
