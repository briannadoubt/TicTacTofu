//
//  Board.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import GameplayKit
import SwiftUI

/// This holds the main logic of the game, as it conforms to the `GKGameModel` protocol.
class Board: NSObject, GKGameModel, ObservableObject {
    
    /// Create a new board
    /// - Parameter initialPlayer: The player who takes the first turn
    /// - Parameter size: The size of the board, or `N` on an `NxN board`
    init(initialPlayer: Player, size: Int) {
        self.size = size
        self.currentPlayer = GamePlayer(player: initialPlayer)
        self.playingAs = initialPlayer
        self.computerPlayer = initialPlayer == .tofu ? .tictacs : .tofu
        super.init()
        createRows(with: size)
    }
    
    /// The size of the board, or `N` on an `NxN board`
    let size: Int
    
    /// Whether or not the game has ended
    @Published var state: GameState = .playing
    
    /// The player that represents the end user
    @Published var playingAs: Player
    
    /// The player that represents the computer and is powered by a `GKStrategist` class on the `GameView`
    @Published var computerPlayer: Player
    
    /// The player who's exptected to play the next move
    @Published var currentPlayer: GamePlayer
    
    /// The rows on the board.
    /// `Row` is just a typealias as follows:
    /// ```
    /// typealias Rows = [Tile]
    /// ```
    /// This means that an array of rows is a matrix, or a nested array. From this we can calculate all of our moves.
    @Published var rows: [Row] = []
    
    /// Reset the game to the initial state
    func reset() {
        rows = []
        state = .playing
        currentPlayer = GamePlayer(player: playingAs)
        createRows(with: size)
    }
    
    /// The current players for GameplayKit
    var players: [GKGameModelPlayer]? {
        return GamePlayer.allPlayers
    }
    
    /// The player who's exptected to play the next move (for GameplayKit)
    var activePlayer: GKGameModelPlayer? {
        currentPlayer
    }
    
    /// Create a board given the input size
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
    
    /// Calculate the current frame's score
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
    
    /// Apply the input game model to the current game model instance. This is for copying and modifying during recursion!
    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            rows = board.rows
            currentPlayer = board.currentPlayer
            state = board.state
        }
    }
    
    /// Return the possible moves given the current state of the board. This is used to determine where the computer is allowed to move next.
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
    
    /// Once the recursion reaches an end state it needs to commit the move. Do that here!
    /// This can be thought of as the recursion moving back up the tree
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        guard let move = gameModelUpdate as? Move else {
            fatalError()
        }
        make(move)
    }
    
    /// Determine if a given player has won
    func isWin(for player: GKGameModelPlayer) -> Bool {
        guard let gamePlayer = player as? GamePlayer else {
            return false
        }
        // Gather all the possible winning positions with the current board values and check if they're all the given player.
        let allWinningPositions = allWinningPositions(on: rows)
        for position in allWinningPositions {
            guard position.allSatisfy({ $0.player != nil && $0.player == gamePlayer.player }) else {
                continue
            }
            return true
        }
        return false
    }
    
    /// Modify the `rows` with the given move's position
    func make(_ move: Move) {
        rows[move.position.row][move.position.column].player = currentPlayer.player
    }
    
    /// Conform to NSCopy for the recursion memory mapping
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(initialPlayer: currentPlayer.player, size: rows.count)
        copy.currentPlayer = currentPlayer
        
        copy.setGameModel(self)
        return copy
    }
    
    /// Loop through all
    func allWinningPositions(on board: [Row]) -> [Row] {
        
        var allWinningPositions: [Row] = []
        
        // Matrix is already mapped in rows
        let rows = board
        
        // Map columns by reversing the row and column indexes
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
        
        // Map diagonal (top left to bottom right)
        var diagonal: [Tile] = []
        for row in 0..<board.count {
            for column in 0..<board.count {
                // If the row index does not equal to the column index then we're not on a relevant tile
                if row != column {
                    continue
                }
                let tile = rows[row][column]
                diagonal.append(tile)
            }
        }
        
        // Map antidiagonal (top right to bottom left)
        var antidiagonal: [Tile] = []
        for row in 0..<board.count {
            for column in 0..<board.count {
                // I love math
                // This one was real easy to think about once I put it on my whiteboard.
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
    
    /// Check whether or not there are any more available moves
    func isFull(_ boardSize: Int) -> Bool {
        emptyTiles.isEmpty
    }
    
    /// All the valid tiles for future moves to be made
    var emptyTiles: [Tile] {
        rows
            .flatMap { $0 } // Flatten to one dimension
            .filter { $0.player == nil } // Filter to only tiles without a player value
    }
}
