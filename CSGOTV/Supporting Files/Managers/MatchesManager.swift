//
//  MatchesManager.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation
import CSGOTVNetworking

final class MatchesManager {
    var teamsDict = [String: CSGOTeam]()
    
    init() {
        teamsDict.updateValue(CSGOTeam(id: 1234567, name: "TBD"), forKey: "TBD")
    }
    
    func parseData(tournaments: [CSGOTournamentResponseModel]) -> [MatchDisplayableContent] {
        // get and populate teamsDict with all teams in the response model
        handleTeams(from: tournaments)
        
        // get all matches separated by tournament
        let matchesByTournament = tournaments.compactMap { $0.matches }
        // enumerate matches by tournament to get tournament data and include on matches displayable content
        return matchesByTournament.enumerated().flatMap { (index, matches) in
            matches.compactMap { match in
                let tournament = tournaments[index]
                let matchTeams = getTeamNames(matchName: match.name)
                // if match is finished or canceled, dismiss data
                guard match.status != .finished,
                      match.status != .canceled,
                      let team1 = teamsDict[matchTeams[0]],
                      let team2 = teamsDict[matchTeams[1]],
                      let matchDate = match.beginAt?.toDate()
                       else { return nil }
                var matchName = tournament.league.name
                if let seriesName = tournament.serie.name {
                    matchName += " - " + seriesName
                }
                return MatchDisplayableContent(
                    matchName: matchName,
                    leagueImageUrl: tournament.league.imageUrl,
                    team1: team1,
                    team2: team2,
                    status: match.status,
                    date: matchDate
                )
            }
        }
    }
    
    private func handleTeams(from tournaments: [CSGOTournamentResponseModel]) {
        tournaments.flatMap { $0.teams }.forEach { teamsDict.updateValue($0, forKey: $0.name) }
    }
    
    private func getTeamNames(matchName: String) -> [String] {
        if let separatorMarkerIndex = matchName.firstIndex(of: ":") {
            let distanceFromSeparator = matchName.distance(from: matchName.startIndex, to: separatorMarkerIndex)
            let indexToDismiss = matchName.count - distanceFromSeparator - ": ".count
            let teamNamesOnlyString = matchName.suffix(indexToDismiss)
            return teamNamesOnlyString.components(separatedBy: " vs ")
        }
        return matchName.components(separatedBy: " vs ")
    }
}
