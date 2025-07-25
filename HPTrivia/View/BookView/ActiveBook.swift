//
//  ActiveBook.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 15/07/25.
//

import SwiftUI

struct ActiveBook: View {
    var book: Book
    
    var body: some View {
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
    }
}

#Preview {
    ActiveBook(book: BookQuestions().books[0])
}
