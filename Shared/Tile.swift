//
//  Tile.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

public class Tile: Identifiable, ObservableObject {
    init(position: Position) {
        self.position = position
    }
    public var id: UUID { UUID() }
    @Published var player: Player?
    var position: Position
}
