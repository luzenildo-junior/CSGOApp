//
//  MatchesContentModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import CSGOTVNetworking

struct MatchesDisplayableContent {
    let matchName: String
    let leagueImageUrl: String?
    let team1: CSGOTeam
    let team2: CSGOTeam
    let status: CSGOMatchGameStatus
    let date: Date?
}
