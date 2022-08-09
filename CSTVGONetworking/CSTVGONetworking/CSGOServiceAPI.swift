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
    
    /// Public service init to be injected in main app service layer
    public init() {
        self.networkingAPI = CSGOTVNetworkingAPI()
    }
    
    /// Internal service init to inject some mocked networking api.
    /// Generally used for testing purposes
    init(networkingAPI: NetworkingAPI = CSGOTVNetworkingAPI()) {
        self.networkingAPI = networkingAPI
    }
}

// MARK: CSGOTournamentSession
extension CSGOServiceAPI: CSGOTournamentSession {
    /// Get tournament implementation. Basically uses combine to fetch tournament data from the backend.
    public func getTournament(page: Int) -> Future<[CSGOTournamentResponse], Error> {
        networkingAPI.fetchData(for: CSGOTournamentRequest(page: page), type: [CSGOTournamentResponse].self)
    }
}

// MARK: CSGOTeamSession
extension CSGOServiceAPI: CSGOTeamSession {
    /// Get team implementation.
    ///     - This func create an array map of ids given as parameter to an array of Future promises response.
    ///     - I made this to make n backend calls to get team informations concurrently. Future awaits for all publishers to finish fetching
    ///     to return the response back to the client
    public func getTeam(with ids: [Int64]) -> Future<[[CSGOTeam]], Error> {
        return Future { promise in
            ids.map { self.networkingAPI.fetchData(for: CSGOTeamRequest(id: $0), type: [CSGOTeam].self)
                .eraseToAnyPublisher() }
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


