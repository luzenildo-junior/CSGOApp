//
//  NetworkingAPIMock.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import XCTest
import Combine
@testable import CSGOTVNetworking

final class NetworkingAPIMock<T: Decodable>: NetworkingAPI {
    var jsonMockedValue: String?
    var urlConvertibleData: URLRequestConvertible?
    
    func fetchData<T>(for urlConvertible: URLRequestConvertible, type: T.Type) -> Future<T, Error> where T : Decodable {
        self.urlConvertibleData = urlConvertible
        return Future { promise in
            guard let mock = self.jsonMockedValue else {
                promise(.failure(APIErrors.JSONParseError))
                return
            }
            let mockedValue: T = mock.decodeJSONString()
            promise(.success(mockedValue))
        }
    }
}
