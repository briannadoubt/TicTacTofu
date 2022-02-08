//
//  Move.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    init(position: Position, player: GamePlayer) {
        self.position = position
        self.player = player
    }
    var position: Position
    var player: GamePlayer
    var value: Int = 0
}
