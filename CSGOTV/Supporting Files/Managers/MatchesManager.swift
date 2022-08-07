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
    
    func parseData(tournaments: [CSGOTournamentResponseModel]) -> [MatchesDisplayableContent] {
        var objects = [MatchesDisplayableContent]()
        let matches = tournaments.compactMap { $0.matches }
        tournaments.flatMap { $0.teams }.forEach { teamsDict.updateValue($0, forKey: $0.name) }
        matches.enumerated().forEach { (index, matchs) in
            objects.append(contentsOf: matchs.compactMap { match in
                let tournament = tournaments[index]
                let matchTeams = getTeamNames(matchName: match.name)
                guard let team1 = teamsDict[matchTeams[0]],
                      let team2 = teamsDict[matchTeams[1]],
                      match.status != .finished,
                      match.status != .canceled else {
                    return nil
                }
                return MatchesDisplayableContent(matchName: "\(tournaments[index].league.name) - \(tournaments[index].serie.name ?? "")",
                                                 leagueImageUrl: tournament.league.imageUrl,
                                                 team1: team1,
                                                 team2: team2,
                                                 status: match.status,
                                                 date: match.beginAt?.toDate())
            })
        }
        return objects
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
