//
//  CSGOTeamMock.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

@testable import CSGOTV
import CSGOTVNetworking

extension CSGOTeam {
    static var mock: CSGOTeam {
        CSGOTeam(
            id: 1234567,
            name: "team-name",
            players: [CSGOPlayer.mock]
        )
    }
}

extension CSGOPlayer {
    static var mock: CSGOPlayer {
        CSGOPlayer(
            firstName: "player-first-name",
            lastName: "player-last-name",
            imageUrl: "http://image.url",
            name: "player-name"
        )
    }
}
