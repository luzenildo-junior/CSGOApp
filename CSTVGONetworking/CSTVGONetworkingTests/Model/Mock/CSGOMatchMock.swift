//
//  CSGOMatchMock.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
@testable import CSGOTVNetworking

extension CSGOMatch {
    static var mock: CSGOMatch {
        CSGOMatch(beginAt: "2022-10-02T13:00:00Z",
                  id: 645212,
                  name: "match-name",
                  status: .notStarted)
    }
}
