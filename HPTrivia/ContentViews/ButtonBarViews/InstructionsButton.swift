//
//  InstructionsButton.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 11/07/25.
//

import SwiftUI

struct InstructionsButton: View {
    @State var showInstructions: Bool = false
    
    @Binding var animateViewsIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animateViewsIn {
                Button {
                    showInstructions.toggle()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: -geo.size.width / 4))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
        .sheet(isPresented: $showInstructions) {
            Instructions()
        }
    }
}

#Preview {
    GeometryReader { geo in
        InstructionsButton(animateViewsIn: .constant(true), geo: geo)
    }
}
