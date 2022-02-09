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
        ZStack {
            if let player = tile.player {
                PlayerImage(player: player)
            } else {
                Button {
                    makeMove()
                } label: {
                    Image("card")
                        .resizable()
                        .scaledToFill()
                }
            }
        }
        .animation(.spring(), value: tile.player == nil)
        .rotation3DEffect(tile.player == nil ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(player: .tictacs, position: Position())) {
            
        }
    }
}
