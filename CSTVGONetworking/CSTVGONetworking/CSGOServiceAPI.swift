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
    private let networkingAPI: NetworkingAPI
    
    public init() {
        self.networkingAPI = CSGOTVNetworkingAPI()
    }
    
    init(networkingAPI: NetworkingAPI = CSGOTVNetworkingAPI()) {
        self.networkingAPI = networkingAPI
    }
}

extension CSGOServiceAPI: CSGOTournamentSession {
    public func getTournament(page: Int) -> Future<[CSGOTournamentResponse], Error> {
        networkingAPI.fetchData(for: CSGOTournamentRequest(page: page), type: [CSGOTournamentResponse].self)
    }
}

extension CSGOServiceAPI: CSGOTeamSession {
    public func getTeam(with ids: [Int64]) -> Future<[[CSGOTeam]], Error> {
        return Future { promise in
            ids.map { self.networkingAPI.fetchData(for: CSGOTeamRequest(id: $0), type: [CSGOTeam].self).eraseToAnyPublisher() }
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


