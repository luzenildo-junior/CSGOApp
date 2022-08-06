//
//  CSGOTournamentAPI.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

public final class CSGOServiceAPI {
    private var cancellables = Set<AnyCancellable>()
    
    public init() { }
}

extension CSGOServiceAPI: CSGOTournamentSession {
    public func getTournament(page: Int) -> Future<[CSGOTournamentResponseModel], Error> {
        CSGOTVNetworkingAPI.fetchData(for: CSGOTournamentRequest(page: page), type: [CSGOTournamentResponseModel].self)
    }
}

extension CSGOServiceAPI: CSGOTeamSession {
    public func getTeam(with ids: [Int64]) -> Future<[CSGOTeam], Error> {
        return Future { promise in
            ids.map { CSGOTVNetworkingAPI.fetchData(for: CSGOTeamRequest(id: $0), type: CSGOTeam.self).eraseToAnyPublisher() }
                .publisher
                .flatMap { $0 }
                .collect()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { teams in
                    promise(.success(teams))
                }
                .store(in: &self.cancellables)
        }
    }
}


