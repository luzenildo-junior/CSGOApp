//
//  HomeSession.swift
//  CSTVGONetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

public protocol CSGOTournamentSession {
    func getTournament(page: Int) -> Future<[CSGOTournamentResponse], Error>
}
