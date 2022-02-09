//
//  GameOutcomeView.swift
//  TicTacTofu
//
//  Created by Bri on 2/9/22.
//

import SwiftUI

struct GameOutcomeView: View {
    
    let outcome: GameOutcome
    @EnvironmentObject var board: Board
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack {
                switch outcome {
                case .winner(let winner):
                    Text(winner.label + " Wins!")
                        .padding()
                case .tie:
                    Text("Tie Game!")
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
            .transition(.scale)
            .animation(.spring(), value: outcome)
        }
    }
}

struct GameOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameOutcomeView(outcome: .winner(.tofu))
            GameOutcomeView(outcome: .winner(.tictacs))
            GameOutcomeView(outcome: .tie)
        }
    }
}
