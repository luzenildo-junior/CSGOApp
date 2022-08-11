//
//  CSGOTeamMock.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
@testable import CSGOTVNetworking

extension CSGOTeam {
    static var mock: CSGOTeam {
        CSGOTeam(id: 12345678, name: "team-name")
    }
}
