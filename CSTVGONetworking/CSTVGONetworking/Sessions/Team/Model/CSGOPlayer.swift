//
//  CSGOPlayerModel.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

public struct CSGOPlayer: Decodable, Equatable {
    public let firstName: String?
    public let lastName: String?
    public let imageUrl: String?
    public let name: String?
    
    public init(
        firstName: String?,
        lastName: String?,
        imageUrl: String?,
        name: String?
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageUrl = imageUrl
        self.name = name
    }
}
