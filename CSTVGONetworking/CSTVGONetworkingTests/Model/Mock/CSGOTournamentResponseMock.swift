//
//  CSGOTournamentResponseMock.swift
//  CSGOTVNetworkingTests
//
//  Created by Luzenildo Junior on 09/08/22.
//

import Foundation
@testable import CSGOTVNetworking

extension CSGOTournamentResponse {
    static var mock: CSGOTournamentResponse {
        CSGOTournamentResponse(league: CSGOLeague.mock,
                                    matches: [CSGOMatch.mock],
                                    teams: [CSGOTeam.mock],
                                    serie: CSGOSerie.mock)
    }
}
