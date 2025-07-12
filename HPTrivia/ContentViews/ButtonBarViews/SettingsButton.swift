//
//  SettingsButton.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 11/07/25.
//

import SwiftUI

struct SettingsButton: View {
    @State var showSettings: Bool = false
    
    @Binding var animateViewsIn: Bool
    
    let geo: GeometryProxy
    
    var body: some View {
        VStack {
            if animateViewsIn {
                Button {
                    showSettings.toggle()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                }
                .transition(.offset(x: geo.size.width / 4))
            }
        }
        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
        .sheet(isPresented: $showSettings) {
            SelectBooks()
        }
    }
}

#Preview {
    GeometryReader { geo in
        SettingsButton(animateViewsIn: .constant(true), geo: geo)
            .environment(Game())
    }
}
