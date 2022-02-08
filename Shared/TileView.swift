//
//  TileView.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct TileView: View {
    
    let size: CGFloat = 64
    let tile: Tile
    
    var makeMove: () -> ()
    
    var body: some View {
        Group {
            if let player = tile.player {
                PlayerImage(player: player)
            } else {
                Button {
                    makeMove()
                } label: {
                    Color(.gray)
                }
            }
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(player: .tictacs, position: Position())) {
            
        }
    }
}
