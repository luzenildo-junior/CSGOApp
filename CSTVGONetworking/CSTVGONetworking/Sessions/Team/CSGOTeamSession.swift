//
//  CSGOTeamSession.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import Combine

public protocol CSGOTeamSession {
    func getTeam(with ids: [Int64]) -> Future<[[CSGOTeam]], Error>
}
