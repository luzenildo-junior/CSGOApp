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
    private let service: MatchDetailsServiceProtocol
    private let match: MatchDisplayableContent
    private var playersDict = [String: [CSGOPlayer]]()
    
    var viewTitle: String {
        match.matchName
    }
    
    init(match: MatchDisplayableContent, service: MatchDetailsServiceProtocol) {
        self.match = match
        self.service = service
    }
    
    /// Returns all the values needed to setup the header
    func getMatchDetailsHeaderContent() -> (team1: CSGOTeam, team2: CSGOTeam, date: String) {
        (match.team1, match.team2, MatchDateParser(with: match.date).toString())
    }
    
    /// Fetch teams informations to populate the playersDict.
    /// I'm using a dict because is easier (and faster) to get players information using the team name key.
    func fetchTeamPlayers() {
        service.fetchTeamsInformations(teams: [match.team1, match.team2]) { result in
            switch result {
            case .success(let teams):
                teams.flatMap { $0 }.forEach { team in
                    guard let players = team.players else { return }
                    self.playersDict.updateValue(players, forKey: team.name)
                }
                self.viewState = .displayPlayers
            case .failure(let error):
                self.viewState = .showError(message: error.localizedDescription)
            }
        }
    }
    
    /// Get number of rows by simply comparing witch of the players array has more elements.
    /// I made it using reduce because in the future we can have more than 2 teams in the playersDict
    func getNumberOfRows() -> Int {
        playersDict.reduce(0) { $1.value.count > $0 ? $1.value.count : $0 }
    }
    
    /// Returns a tuple of platers to populate the player cell.
    /// If the team doesn't have the player for a certain indexPath.row, I simply return nil, so the player space will we empty in the viewCell
    func getPlayers(for indexPath: IndexPath) -> (player1: CSGOPlayer?, player2: CSGOPlayer?) {
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
