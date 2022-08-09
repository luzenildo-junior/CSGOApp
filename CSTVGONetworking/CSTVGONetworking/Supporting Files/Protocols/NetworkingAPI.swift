//
//  NetworkingAPI.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
import Combine

/// Protocol containing the fetch data interface, so we can inject any NetwokingAPI implementation
protocol NetworkingAPI {
    func fetchData<T: Decodable>(for urlConvertible: URLRequestConvertible, type: T.Type) -> Future<T, Error>
}
