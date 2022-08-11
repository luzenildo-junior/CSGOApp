//
//  TournamentResponseModel.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

public struct CSGOTournamentResponse: Decodable, Equatable {
    public let league: CSGOLeague
    public let matches: [CSGOMatch]
    public let teams: [CSGOTeam]
    public let serie: CSGOSerie
}
