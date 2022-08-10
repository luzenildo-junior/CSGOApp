//
//  MatchDetailsViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 08/08/22.
//

import Foundation
import CSGOTVNetworking

final class MatchDetailsViewModel {
    @Published var viewState: MatchDetailsState = .loading
    private let service: MatchDetailsService
    private let match: MatchDisplayableContent
    private var playersDict = [String: [CSGOPlayer]]()
    
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
            switch result {
            case .success(let teams):
                teams.flatMap { $0 }.forEach { team in
                    guard let players = team.players else { return }
                    self.playersDict.updateValue(players, forKey: team.name)
                }
                self.viewState = .displayPlayers
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        playersDict.reduce(0) { $1.value.count > $0 ? $1.value.count : $0 }
    }
    
    func getPlayers(for indexPath: IndexPath) -> (
        player1: CSGOPlayer?,
        player2: CSGOPlayer?
    ) {
        let row = indexPath.row
        let player1 = row < playersDict[match.team1.name]?.count ?? 0 ? playersDict[match.team1.name]?[row] : nil
        let player2 = row < playersDict[match.team2.name]?.count ?? 0 ? playersDict[match.team2.name]?[row] : nil
        return (player1, player2)
    }
}

extension MatchDetailsViewModel {
    enum MatchDetailsState {
        case loading
        case displayPlayers
        case showError(message: String)
    }
}
