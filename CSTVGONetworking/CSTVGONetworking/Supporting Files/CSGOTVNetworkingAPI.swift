//
//  CSGOTVNetworkingAPI.swift
//  CSTVGONetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

enum APIErrors: Error {
    case JSONParseError
    case NetworkError
}

extension APIErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .JSONParseError:
            return NSLocalizedString("An error occurred when trying to get data", comment: "data error")
        case .NetworkError:
            return NSLocalizedString("An Network error occurred, please try again later", comment: "network error")
        }
    }
}

final class CSGOTVNetworkingAPI: NetworkingAPI {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData<T: Decodable>(for urlConvertible: URLRequestConvertible, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                URLSession.shared.dataTaskPublisher(for: try urlConvertible.asURLRequest())
                    .tryMap { (data, response) -> Data in
                        guard let httpResponse = response as? HTTPURLResponse,
                              httpResponse.statusCode == 200 else {
                            throw APIErrors.NetworkError
                        }
                        return data
                    }
                    .decode(type: T.self, decoder: decoder)
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            promise(.failure(error))
                        case .finished:
                            break
                        }
                    } receiveValue: {  promise(.success($0)) }
                    .store(in: &self.cancellables)
            } catch {
                promise(.failure(error))
            }
        }
    }
}
