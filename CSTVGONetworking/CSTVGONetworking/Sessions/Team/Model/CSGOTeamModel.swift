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
    
    public init(
        id: Int64,
        name: String,
        imageUrl: String? = nil,
        players: [CSGOPlayer]? = nil
    ) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.players = players
    }
}
