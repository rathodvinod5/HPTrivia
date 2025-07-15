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
    
    @State var showTempAlert: Bool = false

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
                                .onTapGesture {
                                    game.bookQuestions.changeStatus(for: book.id, status: .inactive)
                                }
                            } else if book.status == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay {
                                            Rectangle().opacity(0.33)
                                        }
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 2)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    game.bookQuestions.changeStatus(for: book.id, status: .active)
                                }
                            } else {
                                ZStack{
                                    Image(book.image)
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay {
                                            Rectangle().opacity(0.75)
                                        }
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color: .white, radius: 5)
                                }
                                .onTapGesture {
                                    showTempAlert.toggle()
                                    game.bookQuestions.changeStatus(for: book.id, status: .active)
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
        .alert("You purchased a new set of questions!", isPresented: $showTempAlert) {
            
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}
