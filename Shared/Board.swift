//
//  Board.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import GameplayKit
import SwiftUI

class Board: NSObject, GKGameModel, ObservableObject {
    
    init(initialPlayer: Player, size: Int) {
        self.size = size
        self.currentPlayer = GamePlayer(player: initialPlayer)
        self.playingAs = initialPlayer
        self.computerPlayer = initialPlayer == .tofu ? .tictacs : .tofu
        super.init()
        createRows(with: size)
    }
    
    let size: Int
    
    @Published var state: GameState = .playing
    
    @Published var playingAs: Player
    @Published var computerPlayer: Player
    
    @Published var currentPlayer: GamePlayer
    
    @Published var rows: [Row] = []
    
    func reset() {
        rows = []
        state = .playing
        currentPlayer = GamePlayer(player: playingAs)
        createRows(with: size)
    }
    
    var players: [GKGameModelPlayer]? {
        return GamePlayer.allPlayers
    }
    
    var activePlayer: GKGameModelPlayer? {
        currentPlayer
    }
    
    func createRows(with size: Int) {
        var rows = [[Tile]]()
        for row in 0..<size {
            rows.append([])
            for column in 0..<size {
                rows[row].append(Tile(player: nil, position: Position(row: row, column: column)))
            }
        }
        self.rows = rows
    }
    
    func score(for player: GKGameModelPlayer) -> Int {
        guard let gamePlayer = player as? GamePlayer else {
            return 0
        }
        if isWin(for: gamePlayer) {
            return 1
        }
        if isWin(for: gamePlayer.opponent) {
            return -1
        }
        return 0
    }
    
    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            rows = board.rows
            currentPlayer = board.currentPlayer
            state = board.state
        }
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        guard let gamePlayer = player as? GamePlayer else {
            return nil
        }
        if isWin(for: gamePlayer) || isWin(for: gamePlayer.opponent) {
            return nil
        }
        let moves: [Move] = emptyTiles.map { Move(position: $0.position, player: gamePlayer) }
        return moves
    }
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        guard let move = gameModelUpdate as? Move else {
            fatalError()
        }
        make(move)
    }
    
    func isWin(for player: GKGameModelPlayer) -> Bool {
        guard let gamePlayer = player as? GamePlayer else {
            return false
        }
        let allWinningPositions = allWinningPositions(on: rows)
        for position in allWinningPositions {
            guard position.allSatisfy({ $0.player != nil && $0.player == gamePlayer.player }) else {
                continue
            }
            return true
        }
        return false
    }
    
    func make(_ move: Move) {
        rows[move.position.row][move.position.column].player = currentPlayer.player
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(initialPlayer: currentPlayer.player, size: rows.count)
        copy.currentPlayer = currentPlayer
        
        copy.setGameModel(self)
        return copy
    }
    
    func allWinningPositions(on board: [Row]) -> [Row] {
        
        var allWinningPositions: [Row] = []
        
        let rows = board
        
        var columns: [Row] = []
        for row in 0..<board.count {
            for column in 0..<board.count {
                if columns.count == column {
                    columns.append([])
                }
                let tile = rows[row][column]
                columns[column].append(tile)
            }
        }
        
        var diagonal: [Tile] = []
        for row in 0..<board.count {
            for column in 0..<board.count {
                if row != column {
                    continue
                }
                let tile = rows[row][column]
                diagonal.append(tile)
            }
        }
        
        var antidiagonal: [Tile] = []
        for row in 0..<board.count {
            for column in 0..<board.count {
                if row + column != board.count - 1 {
                    continue
                }
                let tile = rows[row][column]
                antidiagonal.append(tile)
            }
        }
        
        allWinningPositions.append(contentsOf: rows)
        allWinningPositions.append(contentsOf: columns)
        allWinningPositions.append(diagonal)
        allWinningPositions.append(antidiagonal)
        
        return allWinningPositions
    }
    
    func isFull(_ boardSize: Int) -> Bool {
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                let tile = rows[row][column]
                if tile.player == nil {
                    return false
                }
            }
        }
        return true
    }
    
    var emptyTiles: [Tile] {
        flatRows.filter({ $0.player == nil })
    }
    
    var flatRows: [Tile] {
        return rows.flatMap { $0 }
    }
}
