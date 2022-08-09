//
//  CSGOTeamRequest.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

struct CSGOTeamRequest: APIRequestConfiguration {
    let id: Int64
    
    var path: String {
        "/teams"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    /// Parameters for team request
    ///     - Parameters:
    ///         - id: team id to get informations from
    var parameters: RequestParams {
        .queryItems(["filter[id]": id])
    }
}
