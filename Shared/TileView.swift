//
//  TileView.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct TileView: View {
    
    @EnvironmentObject var board: Board
    
    let size: CGFloat = 64
    @StateObject var tile: Tile
    
    var makeMove: () -> ()
    
    var body: some View {
        ZStack {
            if let player = tile.player {
                PlayerImage(player: player)
            } else {
                Button {
                    withAnimation(.spring()) {
                        makeMove()
                    }
                } label: {
                    Image("card")
                        .resizable()
                        .scaledToFill()
                }
                .disabled(board.currentPlayer.player == board.computerPlayer)
                .transition(.scale)
            }
        }
        .animation(.spring(), value: tile.player == nil)
        .rotation3DEffect(tile.player == nil ? Angle(degrees: 180) : Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(tile: Tile(position: Position())) {
            
        }
    }
}
