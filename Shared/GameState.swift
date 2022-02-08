//
//  GameState.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

enum GameState: Identifiable {
    case playing
    case end(_ outcome: GameOutcome)
    
    var id: String {
        switch self {
        case .playing:
            return "playing"
        case .end(let outcome):
            switch outcome {
            case .winner(let winner):
                switch winner {
                case .tofu:
                    return "tofu wins"
                case .tictacs:
                    return "tictacs win"
                }
            case .tie:
                return "tie"
            }
        }
    }
}
