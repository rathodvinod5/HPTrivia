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
    
    var activeBooks: Bool {
        for book in game.bookQuestions.books {
            if book.status == .active {
                return true
            }
        }
        
        return false
    }

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
                                ActiveBook(book: book)
                                    .onTapGesture {
                                        game.bookQuestions.changeStatus(for: book.id, to: .inactive)
                                    }
                                
                            } else if book.status == .inactive {
                                InactiveBook(book: book)
                                    .onTapGesture {
                                        game.bookQuestions.changeStatus(for: book.id, to: .active)
                                    }
                                
                            } else {
                                LockedBook(book: book)
                                    .onTapGesture {
                                        showTempAlert.toggle()
                                        game.bookQuestions.changeStatus(for: book.id, to: .active)
                                    }
                            }
                        }
                    }
                    .padding()
                }
                
                if !activeBooks {
                    Text("You must selected atleast one book!")
                        .multilineTextAlignment(.center)
                }
                
                Button("Done") {
                    dismiss()
                }
                .font(.largeTitle)
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .foregroundStyle(.white)
                .disabled(!activeBooks)
            }
        }
        .interactiveDismissDisabled(!activeBooks)
        .alert("You purchased a new set of questions!", isPresented: $showTempAlert) {
            
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}
