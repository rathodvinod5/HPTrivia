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
    
    @State private var store = Store()
    
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
                            if book.status == .active || (book.status == .locked && store.purchased.contains(book.image)) {
                                ActiveBook(book: book)
                                    .task {
                                        game.bookQuestions.changeStatus(for: book.id, to: .active)
                                    }
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
                                        let product = store.products[book.id-4]
                                        
                                        Task {
                                            await store.purchase(product)
                                        }
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
        .task {
            await store.loadProducts()
        }
    }
}

#Preview {
    SelectBooks()
        .environment(Game())
}
