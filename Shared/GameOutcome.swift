//
//  GameOutcome.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

enum GameOutcome: Equatable {
    case winner(_ player: Player)
    case tie
}
