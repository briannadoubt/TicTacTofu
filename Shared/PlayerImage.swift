//
//  PlayerImage.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct PlayerImage: View {
    let player: Player
    var body: some View {
        switch player {
        case .tictacs:
            Image("tictacs")
                .resizable()
                .scaledToFit()
        case .tofu:
            Image("tofu")
                .resizable()
                .scaledToFit()
        }
    }
}

struct PlayerImage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerImage(player: .tictacs)
    }
}
