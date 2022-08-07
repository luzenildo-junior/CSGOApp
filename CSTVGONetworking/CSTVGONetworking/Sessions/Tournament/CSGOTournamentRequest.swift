//
//  CSGOTournamentAPI.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

struct CSGOTournamentRequest: APIRequestConfiguration {
    let page: Int
    
    var path: String {
        return "/tournaments"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: RequestParams {
        return .queryItems([
            "page": page,
            "per_page": 6,
            "sort": "begin_at",
            "range[begin_at]": "\(Date().twoDaysAgo.stringFormatted),\(Date().next3Months.stringFormatted)"
        ])
    }
}
