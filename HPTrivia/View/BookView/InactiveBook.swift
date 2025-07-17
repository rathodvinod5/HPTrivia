//
//  InactiveBook.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 15/07/25.
//

import SwiftUI

struct InactiveBook: View {
    var book: Book

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
            
            Image(systemName: "circle")
                .font(.largeTitle)
                .foregroundStyle(.green)
                .shadow(radius: 2)
                .padding(3)
        }
    }
}

#Preview {
    InactiveBook(book: BookQuestions().books[0])
}
