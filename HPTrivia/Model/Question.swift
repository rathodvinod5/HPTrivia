//
//  Question.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 29/06/25.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    let answer: String
    let wrong: [String]
    let book: Int
    let hint: String
}
