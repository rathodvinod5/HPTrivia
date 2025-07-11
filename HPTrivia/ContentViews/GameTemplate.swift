//
//  GameTemplate.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 11/07/25.
//

import SwiftUI

struct GameTemplate: View {
    @Binding var animateViewsIn: Bool
    
    var body: some View {
        VStack {
            if animateViewsIn {
                VStack {
                    Image(systemName: "bolt.fill")
                        .imageScale(.large)
                        .font(.largeTitle)
                    Text("HP")
                        .font(.custom("PartyLetPlain", size: 70))
                        .padding(.bottom, -50)
                    Text("Trivia")
                        .font(.custom("PartyLetPlain", size: 60))
                }
                .padding(.top, 70)
                .transition(.move(edge: .top))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
    }
}

#Preview {
    GameTemplate(animateViewsIn: .constant(true))
}
