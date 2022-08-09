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
    
    /// Parameters for the tournament request
    ///     - Parameters:
    ///         - page: current page for pagination purposes
    ///         - per_page: number of tournaments per page
    ///         - sort: the way backend will sort tournament data to return it back to the api - in this case, it will be sorted by begin_at date.
    ///         - range[begin_at]: range of date which backend will filter the tournament data
    ///    - `Disclaimer`:
    ///         - This is clearly not the best way to get data from the backend. But looks like this PandaScore api were not made to
    ///         enthusiast people use the data to create apps. Even sorting with begin_at, and specifying a range of dates, it messes with the data
    ///         returning a lot of trash and data badly sorted. This was the best way I found to at least retrieve some data to be sorted outside this module
    ///         (probably in some ViewModel layer).
    ///         - In a real world scenario, I understand that the backend should send the data well formed and sorted, so the mobile can
    ///         display it propperly (imagine having to create managers to handle all bad formatted data retrieved from the backend in iOS, Android,
    ///         or any other platform. This would lead to a lot of different bugs in different platforms. Not cool at all!)
    ///         - This is why I set the sort and range directly inside this module, and not set it in the client using this networking api.
    ///         It was proposital, I know that the right way to do it is to get these values from the client side, and not hardcode it in the api side.
    var parameters: RequestParams {
        return .queryItems([
            "page": page,
            "per_page": 5,
            "sort": "begin_at",
            "range[begin_at]": "\(Date().twoDaysAgo.stringFormatted),\(Date().next3Months.stringFormatted)"
        ])
    }
}
