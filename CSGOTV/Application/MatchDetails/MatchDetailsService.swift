//
//  MatchDetailsService.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import CSGOTVNetworking
import Combine
import Foundation

protocol MatchDetailsServiceProtocol {
    func fetchTeamPlayers(
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
    func fetchTeamPlayers(
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
