//
//  HomeService.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import CSGOTVNetworking
import Combine

final class MatchesService {
    private var cancellables = Set<AnyCancellable>()
    let service: CSGOTournamentSession
    
    init(service: CSGOTournamentSession) {
        self.service = service
    }
    
    func fetchTournaments(for page: Int, completion: @escaping ( Result<[CSGOTournamentResponseModel], Error>) -> ()) {
        service.getTournament(page: page)
            .receive(on: DispatchQueue.main)
            .sink { promiseCompletion in
                switch promiseCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { tournament in
                completion(.success(tournament))
            }
            .store(in: &cancellables)

    }
}
