//
//  CSGOLeagueMock.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
@testable import CSGOTVNetworking

extension CSGOLeague {
    static var mock: CSGOLeague {
        CSGOLeague(imageUrl: "http://image.url", name: "league-name")
    }
}
