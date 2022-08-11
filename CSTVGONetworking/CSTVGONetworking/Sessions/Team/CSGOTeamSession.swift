//
//  CSGOTeamSession.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

public protocol CSGOTeamSession {
    /// Fetches team informations
    /// - Parameters:
    ///     - ids: array of team ids you nedd information from
    /// - `Return`:
    ///     - Future publisher containing a promise with an array of CSGOTeam object or error.
    func getTeam(with ids: [Int64]) -> Future<[[CSGOTeam]], Error>
}
