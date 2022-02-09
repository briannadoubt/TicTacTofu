//
//  GameBoardView.swift
//  TicTacTofu
//
//  Created by Bri on 2/9/22.
//

import SwiftUI
import GameplayKit

struct GameBoardView: View {
    
    init(boardSize: Int) {
        self.boardSize = boardSize
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 10
        strategist.randomSource = GKARC4RandomSource()
    }
    
    let boardSize: Int
    let cellSize: CGFloat = 64
    
    @EnvironmentObject var board: Board
    
    var strategist: GKMinmaxStrategist
    
    /// Play the given tile as the current player
    func makeMove(on tile: Tile) {
        let newMove = Move(position: tile.position, player: board.currentPlayer)
        withAnimation(.spring()) {
            board.make(newMove)
        }
        checkForEndOfGame()
        board.currentPlayer = board.currentPlayer.opponent
    }

    /// Determine the best next move for the computer to play, then play it.
    func makeComputerMove() {
        Task {
            if let bestMove = strategist.bestMoveForActivePlayer() as? Move {
                board.make(bestMove)
            } else if let randomPosition = board.emptyTiles.randomElement()?.position {
                // As mentioned in the docs, "This method returns nil if the current player is invalid or has no available moves"... There must be something wrong with my implementation.
                // If bestMoveForActivePlayer returns nil but there are still valid spots to play on the board, pick a random open tile on the board and make a move there.
                let randomMove = Move(position: randomPosition, player: board.currentPlayer)
                board.make(randomMove)
            }
            checkForEndOfGame()
            switchPlayers()
        }
    }
    
    func switchPlayers() {
        withAnimation {
            board.currentPlayer = board.currentPlayer.opponent
        }
    }
    
    /// Check if the current player has won, then check for a tie.
    /// If either of these are true, set the board state to reflect that fact.
    func checkForEndOfGame() {
        if board.isWin(for: board.currentPlayer) {
            board.state = .end(.winner(board.currentPlayer.player))
        }
        if board.isFull(boardSize) {
            board.state = .end(.tie)
        }
    }

    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: true) {
            VStack {
                ForEach(board.rows) { row in
                    HStack {
                        ForEach(row) { tile in
                            TileView(tile: tile) {
                                makeMove(on: tile)
                            }
                            .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }
            .padding(44)
            .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 20))
            .background {
                Image("felt")
                    .resizable(resizingMode: .tile)
                    .ignoresSafeArea()
            }
            .cornerRadius(44)
        }
        .onReceive(board.$currentPlayer) { currentPlayer in
            if currentPlayer.player == board.computerPlayer {
                makeComputerMove()
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView(boardSize: 3)
    }
}
