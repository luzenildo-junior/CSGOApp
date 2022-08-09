//
//  MatchDetailsViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import Foundation
import CSGOTVNetworking

final class MatchDetailsViewModel {
    private let service: MatchDetailsService
    private let match: MatchDisplayableContent
    
    var viewTitle: String {
        match.matchName
    }
    
    init(match: MatchDisplayableContent, service: MatchDetailsService) {
        self.match = match
        self.service = service
    }
    
    func getMatchDetailsHeaderContent() -> (
        team1: CSGOTeam,
        team2: CSGOTeam,
        date: String
    ) {
        (match.team1, match.team2, MatchDateParser(with: match.date).toString())
    }
    
    func fetchTeamPlayers() {
        service.fetchTeamPlayers(teams: [match.team1, match.team2]) { result in
            
        }
    }
}
