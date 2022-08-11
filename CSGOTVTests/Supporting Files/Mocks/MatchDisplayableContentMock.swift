//
//  MatchDisplayableContentMock.swift
//  CSGOTVTests
//
//  Created by Luzenildo Junior on 10/08/22.
//

import Foundation
@testable import CSGOTV
import CSGOTVNetworking

extension MatchDisplayableContent {
    static var mock: MatchDisplayableContent {
        MatchDisplayableContent(matchName: "match-name",
                                leagueImageUrl: nil,
                                team1: CSGOTeam.mock,
                                team2: CSGOTeam.mock,
                                status: .notStarted,
                                date: Date())
    }
}
