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
    
    var parameters: RequestParams {
        .queryItems(["filter[id]": id])
    }
}
