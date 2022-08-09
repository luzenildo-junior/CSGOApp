//
//  MatchDetailsService.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import CSGOTVNetworking
import Combine
import Foundation

final class MatchDetailsService {
    private var cancellables = Set<AnyCancellable>()
    let service: CSGOTeamSession
    
    init(service: CSGOTeamSession) {
        self.service = service
    }
    
    func fetchTeamPlayers(teams: [CSGOTeam], completion: @escaping (Result<[[CSGOPlayer]], Error>) -> ()) {
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
                let playersMap = teams.flatMap { $0 }.compactMap { $0.players }
                completion(.success(playersMap))
            }.store(in: &cancellables)
    }
}
