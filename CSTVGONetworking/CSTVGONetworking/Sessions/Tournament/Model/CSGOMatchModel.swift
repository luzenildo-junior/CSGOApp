//
//  MatchesResponseModel.swift
//  CSTVGONetworking
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

public struct CSGOMatch: Decodable {
    public let beginAt: String?
    public let id: Int64
    public let name: String
    public let status: CSGOMatchGameStatus
    
}

public enum CSGOMatchGameStatus: String, Decodable {
    case notStarted = "not_started"
    case running
    case postponed
    case finished
    case canceled
}

extension CSGOMatchGameStatus: Comparable {
    private var comparisonValue: Int {
        switch self {
        case .running:
            return 0
        case .notStarted:
            return 1
        default:
            return 2
        }
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.comparisonValue < rhs.comparisonValue
    }
}
