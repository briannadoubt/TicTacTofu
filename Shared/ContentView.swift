//
//  ContentView.swift
//  Shared
//
//  Created by Bri on 2/5/22.
//

import SwiftUI
import GameKit

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Made a super simple Tic-Tac-Toe game for a job interview. Themed it after a block of tofu that I have in my fridge. Thought of a silly pun regarding Tic-Tacs and Tofu.")
                }
                Section {
                    Text("The question remains: ") + Text("\"But, why tofu?\"").bold()
                }
                Section {
                    Text("This is a question I have grappled with over the course of developing this game. This semi-satirical exostential rabbit hole has been short-lived and petty in nature, but somehow, I find it poetic in it's simplicity.")
                }
                Section {
                    NavigationLink("Anyways...") {
                        
                    }
                    .foregroundColor(.accentColor)
                }
            }
            .navigationTitle("Tic-Tacs & Tofu")
            .toolbar {
                ToolbarItem {
                    NavigationLink("Skip to game...") {
                        OptionsView()
                    }
                }
            }
        }
        .lineLimit(nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
