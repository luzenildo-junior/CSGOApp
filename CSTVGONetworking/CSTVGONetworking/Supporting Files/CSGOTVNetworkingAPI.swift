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

final class CSGOTVNetworkingAPI {
    static func fetchData<T: Decodable>(for urlConvertible: URLRequestConvertible, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            do {
                let dataTask = URLSession.shared.dataTask(with: try urlConvertible.asURLRequest()) { data, response, error in
                    guard let data = data else {
                        if let error = error {
                            promise(.failure(error))
                        }
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decoder.decode(T.self, from: data)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
                dataTask.resume()
            } catch {
                promise(.failure(error))
            }
        }
    }
}
