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
        
        _board = ObservedObject(initialValue: Board(initialPlayer: playingAs, size: boardSize))
        
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 10
        strategist.randomSource = GKARC4RandomSource()
    }
    
    let boardSize: Int
    let cellSize: CGFloat = 64
    let playingAs: Player
    
    @ObservedObject var board: Board
    
    @State var error: Error?
    @State var errorIsPresented = false
    
    @State var outcomeAlertIsPresented = false
    
    var strategist: GKMinmaxStrategist
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeMove(on tile: Tile) {
        let newMove = Move(position: tile.position, player: board.currentPlayer)
        board.make(newMove)
        checkForWinner()
        board.currentPlayer = board.currentPlayer.opponent
    }

    func makeComputerMove() {
        if let bestMove = strategist.bestMoveForActivePlayer() as? Move { // As mentioned in the docs, "This method returns nil if the current player is invalid or has no available moves"
            board.make(bestMove)
        } else if let randomPosition = board.emptyTiles.randomElement()?.position {
            let randomMove = Move(position: randomPosition, player: board.currentPlayer)
            board.make(randomMove)
        }
        checkForWinner()
        board.currentPlayer = board.currentPlayer.opponent
    }
    
    func checkForWinner() {
        if board.isWin(for: board.currentPlayer) {
            board.state = .end(.winner(board.currentPlayer.player))
        }
        if board.isFull(boardSize) {
            board.state = .end(.tie)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                WinnerParty(geometry: geometry, state: board.state)
                VStack {
                    switch board.state {
                    case .playing:
                        ScrollView([.vertical, .horizontal], showsIndicators: true) {
                            if board.state.id == GameState.playing.id {
                                VStack {
                                    ForEach(board.rows) { row in
                                        HStack {
                                            ForEach(row) { tile in
                                                TileView(tile: tile) {
                                                    makeMove(on: tile)
                                                }
                                                .frame(width: cellSize, height: cellSize)
                                                .cornerRadius(20)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    case .end(let outcome):
                        VStack {
                            switch outcome {
                            case .winner(let winner):
                                Text(winner.label + " wins!")
                                    .padding()
                            case .tie:
                                Text("Tie game!")
                                    .padding()
                            }
                            Button("Play Again") {
                                board.reset()
                            }
                            .font(.headline.bold())
                            .padding()
                        }
                        .font(.largeTitle.bold())
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                    }
                }
            }
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
        .onReceive(board.$currentPlayer) { currentPlayer in
            if currentPlayer.player == board.computerPlayer {
                makeComputerMove()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(playingAs: .tictacs, boardSize: 3)
    }
}
