//
//  GameView.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI
import GameplayKit

struct GameView: View {
    
    init(playingAs: Player, boardSize: Int) {
        self.boardSize = boardSize
        self.playingAs = playingAs
        _board = StateObject(wrappedValue: Board(initialPlayer: playingAs, size: boardSize))
    }
    
    let boardSize: Int
    let playingAs: Player
    
    @StateObject var board: Board
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch board.state {
                case .playing:
                    // Game Board
                    GameBoardView(boardSize: boardSize)
                        .environmentObject(board)
                    
                case .end(let outcome):
                    WinnerParty(geometry: geometry, outcome: outcome)
                    GameOutcomeView(outcome: outcome)
                        .environmentObject(board)
                }
            }
        }
        .background {
            Image("background")
                .resizable(resizingMode: .tile)
                .ignoresSafeArea()
        }
        .navigationTitle("Tic-Tacs & Tofu")
        .toolbar {
            ToolbarItem {
                Menu {
                    Button("Start Over", role: .destructive) {
                        board.reset()
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .onDisappear {
            board.reset()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(playingAs: .tictacs, boardSize: 3)
    }
}
