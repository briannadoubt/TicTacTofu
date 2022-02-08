//
//  GamePlayer.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import GameplayKit

class GamePlayer: NSObject, GKGameModelPlayer {
    init(player: Player) {
        self.playerId = player.rawValue
    }
    var opponent: GamePlayer {
        let opponentId = playerId == 1 ? -1 : 1
        return GamePlayer(player: Player(rawValue: opponentId)!)
    }
    var playerId: Int
    var player: Player {
        Player(rawValue: playerId)!
    }
    static var allPlayers: [GamePlayer] = [GamePlayer(player: .tofu), GamePlayer(player: .tictacs)]
}
