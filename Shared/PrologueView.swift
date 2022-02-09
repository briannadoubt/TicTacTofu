//
//  PrologueView.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct PrologueView: View {
    
    var body: some View {
        Form {
            Section {
                Text("Once upon a time... Just kidding 🤪")
            }
            Section {
                Text("Tic-Tacs & Tofu is just like Tic-Tac-Toe, except that one player drops Tic-Tacs, and the other player drops blocks of Tofu.")
            }
            Section {
                Text ("Each player takes turns placing their respective objects. The first player to completely fill a column, a row, or a diagonal slice through the center of the board, wins! If neither player manages to do accomplish any of these, and there are no more possible winning paths, the game results in a tie.")
            }
            Section {
                Text("The game picker allows a maximum board size of 25x25, but the implementation is NxN and scales to whatever the \"boardSize\" variable is set to in the source code.")
            }
            Section {
                Text("I've also set up a simple algorithm for the computer to choose it's next move, which has a commented explaination in the source code.")
            }
            Section {
                NavigationLink("On to the game!") {
                    OptionsView()
                }
            }
        }
        .navigationTitle("Prologue")
    }
}

struct PrologueView_Previews: PreviewProvider {
    static var previews: some View {
        PrologueView()
    }
}
