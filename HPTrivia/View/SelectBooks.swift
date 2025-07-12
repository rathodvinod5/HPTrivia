//
//  SelectBooks.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 12/07/25.
//

import SwiftUI

struct SelectBooks: View {
    @Environment(\.dismiss) var dismiss
    @Environment(Game.self) private var game

    var body: some View {
        ZStack {
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(Color.brown)
            
            VStack {
                Text("Which books would yo like to see questions from!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(game.bookQuestions.books) { book in
                            if book.status == .active {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 2)
                                        .padding(3)
                                }
                            } else if book.status == .inactive {
                                ZStack{
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                            } else {
                                ZStack{
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}
