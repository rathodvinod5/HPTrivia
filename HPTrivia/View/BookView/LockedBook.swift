//
//  LockedBook.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 15/07/25.
//

import SwiftUI

struct LockedBook: View {
    var book: Book
    
    var body: some View {
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
    }
}

#Preview {
    LockedBook(book: BookQuestions().books[0])
}
