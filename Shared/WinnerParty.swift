//
//  WinnerParty.swift
//  TicTacTofu
//
//  Created by Bri on 2/8/22.
//

import SwiftUI

struct WinnerParty: View {
    let geometry: GeometryProxy
    @State var outcome: GameOutcome
    var body: some View {
        VStack {
            switch outcome {
            case .winner(let winner):
                ParticlesEmitter {
                    EmitterCell()
                        .content(.image(UIImage(named: winner == .tofu ? "tofu" : "tictacs")!))
                        .color(.white)
                        .lifetime(30)
                        .birthRate(15)
                        .scale(0.1)
                        .scaleRange(0.06)
                        .scaleSpeed(-0.02)
                        .velocity(100)
                        .velocityRange(50)
                        .emissionLongitude(.pi)
                        .emissionRange(.pi / 8)
                        .spin(1)
                        .spinRange(3)
                }
                .emitterSize(CGSize(width: geometry.size.width, height: 1))
                .emitterShape(.line)
                .emitterPosition(CGPoint(x: geometry.size.width / 2, y: -200))
            case .tie:
                ParticlesEmitter {
                    EmitterCell()
                        .content(.image(UIImage(named: "tie")!))
                        .color(.white)
                        .lifetime(30)
                        .birthRate(15)
                        .scale(0.1)
                        .scaleRange(0.06)
                        .scaleSpeed(-0.02)
                        .velocity(100)
                        .velocityRange(50)
                        .emissionLongitude(.pi)
                        .emissionRange(.pi / 8)
                        .spin(1)
                        .spinRange(3)
                }
                .emitterSize(CGSize(width: geometry.size.width, height: 1))
                .emitterShape(.line)
                .emitterPosition(CGPoint(x: geometry.size.width / 2, y: -200))
            }
            Spacer()
        }
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            WinnerParty(geometry: geometry, outcome: .winner(.tofu))
        }
    }
}
