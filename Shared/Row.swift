//
//  Row.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import Foundation

typealias Row = [Tile]

extension Row: Identifiable {
    public var id: String {
        self.map { "\($0.position.row)\($0.position.column)" }.joined()
    }
}
