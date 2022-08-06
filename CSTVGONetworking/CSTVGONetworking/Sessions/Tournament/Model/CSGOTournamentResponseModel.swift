//
//  TournamentResponseModel.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

public struct CSGOTournamentResponseModel: Decodable {
    public let league: CSGOLeague
    public let matches: [CSGOMatch]
    public let teams: [CSGOTeam]
    public let serie: CSGOSerie
}
