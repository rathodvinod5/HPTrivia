//
//  Book.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 11/07/25.
//

struct Book: Codable, Identifiable {
    let id: Int
    let image: String
    let questions: [Question]
    var status: BookStatus
}

enum BookStatus: Codable {
    case active, inactive, locked
}
