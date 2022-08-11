//
//  MatchesContentModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import CSGOTVNetworking

public struct MatchDisplayableContent {
    let matchName: String
    let leagueImageUrl: String?
    let team1: CSGOTeam
    let team2: CSGOTeam
    let status: CSGOMatchGameStatus
    let date: Date
    
    public init(
        matchName: String,
        leagueImageUrl: String?,
        team1: CSGOTeam,
        team2: CSGOTeam,
        status: CSGOMatchGameStatus,
        date: Date
    ) {
        self.matchName = matchName
        self.leagueImageUrl = leagueImageUrl
        self.team1 = team1
        self.team2 = team2
        self.status = status
        self.date = date
    }
}
