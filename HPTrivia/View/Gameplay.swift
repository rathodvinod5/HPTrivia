//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 21/07/25.
//

import SwiftUI

struct Gameplay: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                
                VStack {
                    // MARK: Controls
                    
                    // MARK: Question
                    
                    // MARK: Hints
                    
                    // MARK: answers
                }
                .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                
                // MARK: Celebrations
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Gameplay()
}
