//
//  Tile.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

public struct Tile: Identifiable {
    public var id: UUID { UUID() }
    var player: Player?
    var position: Position
}
