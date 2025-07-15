//
//  Book.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 11/07/25.
//

struct Book : Identifiable {
    let id: Int
    let image: String
    let questions: [Question]
    var status: BookStatus
}

enum BookStatus {
    case active, inactive, locked
}
