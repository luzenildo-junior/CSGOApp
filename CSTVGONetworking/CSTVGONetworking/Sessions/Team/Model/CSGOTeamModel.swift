//
//  CSGOTeamModel.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

public struct CSGOTeam: Decodable {
    public let id: Int64
    public let name: String
    public let imageUrl: String?
    public let players: [CSGOPlayer]?
}
