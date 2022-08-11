//
//  HomeSession.swift
//  CSTVGONetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

public protocol CSGOTournamentSession {
    /// Fetches tournament informations
    /// - Parameters:
    ///     - page: page result for pagination purposes
    /// - `Return`:
    ///     - Future publisher containing a promise with an array of CSGOTournamentResponse object or error.
    func getTournament(page: Int) -> Future<[CSGOTournamentResponse], Error>
}
