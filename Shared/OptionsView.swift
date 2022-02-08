//
//  OptionsView.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct OptionsView: View {
    
    @SceneStorage("isShowingGame") var isShowingGame = false
    @SceneStorage("numberOfColumns") var boardSize: Int = 3
    
    @State var playingAs = Player.tofu
    
    var body: some View {
        let startButton = NavigationLink("Start!") {
            GameView(playingAs: playingAs, boardSize: boardSize)
        }

        Form {
            Section {
                Text("Board size")
                Picker(selection: $boardSize) {
                    ForEach(3...25, id: \.self) { size in
                        Text("\(size) by \(size)")
                    }
                } label: {
                    Text("Board Size")
                }
                .pickerStyle(.wheel)
            }
            Section {
                DisclosureGroup {
                    ForEach(Player.allCases) { player in
                        Button {
                            withAnimation {
                                playingAs = player
                            }
                        } label: {
                            Label {
                                HStack {
                                    Text(player.label).foregroundColor(.primary)
                                    if playingAs == player {
                                        Spacer()
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.accentColor)
                                    }
                                }
                            } icon: {
                                PlayerImage(player: player)
                            }
                        }
                    }
                } label: {
                    Label {
                        Text(playingAs.label)
                    } icon: {
                        PlayerImage(player: playingAs)
                    }
                }
            }
            Section {
                startButton
            }
        }
        .navigationTitle("Options")
        .toolbar {
            ToolbarItem {
                startButton
            }
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
