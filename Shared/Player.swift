//
//  File.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

enum Player: Int, Identifiable, CaseIterable {
    case tictacs = -1
    case tofu = 1
    var id: Int {
        rawValue
    }
    var label: String {
        switch self {
        case .tictacs:
            return "Tic-Tacs"
        case .tofu:
            return "Tofu"
        }
    }
    var opponent: Player {
        self == .tofu ? .tictacs : .tofu
    }
}
