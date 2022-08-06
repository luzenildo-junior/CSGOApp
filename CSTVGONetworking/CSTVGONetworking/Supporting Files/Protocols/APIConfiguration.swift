//
//  APIConfiguration.swift
//  CSGOTVSDK
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.pandascore.co/csgo"
    static let accessToken = "mSdYPTZYVLvYX9LwJp_nOrUQ7Hr1xoA3q7d2a-5sVNSfpfvAcZs"
}

protocol APIRequestConfiguration: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
}

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension APIRequestConfiguration {
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: APIConstants.baseURL)
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue("Bearer \(APIConstants.accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)

        // Parameters
        switch parameters {
        case .body(let params):
            if params.count > 0 {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }

        case .queryItems(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string: (url?.appendingPathComponent(path).absoluteString)!)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}
