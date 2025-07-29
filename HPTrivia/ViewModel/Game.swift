//
//  Game.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 12/07/25.
//

import SwiftUI

@Observable
class Game {
    var bookQuestions = BookQuestions()
    
    var gameScore = 0
    var questionScore = 5
    var recentScores = [0, 0, 0]
    
    var activeQuestions: [Question] = []
    var answeredQuestions: [Int] = []
//    var currentQuestion = try! JSONDecoder().decode([Question].self, from:
//        Data(contentsOf: Bundle.main.url(forResource: "book_questions", withExtension: "json")!))[0]
    var answers: [String] = []
    
    var currentQuestion: Question = Question(id: 0, question: "", answer: "", wrong: [], book: 0, hint: "") // Placeholder
    
    let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "RecentScore")
    
    init() {
        if let url = Bundle.main.url(forResource: "book_questions", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let questions = try? JSONDecoder().decode([Question].self, from: data),
           !questions.isEmpty {
            currentQuestion = questions[0]
        } else {
            print("❌ Failed to load or decode book_questions.json")
        }
        loadScore()
    }
    
    func startGame() {
        for book in bookQuestions.books {
            if book.status == .active {
                for question in book.questions {
                    activeQuestions.append(question)
                }
            }
        }
        
        newQuestion()
    }
    
    func newQuestion() {
        if answeredQuestions.count == activeQuestions.count {
            answeredQuestions = []
        }
        
        currentQuestion = activeQuestions.randomElement()!
        
        while(answeredQuestions.contains(currentQuestion.id)) {
            currentQuestion = activeQuestions.randomElement()!
        }
        
        answers = []
        answers.append(currentQuestion.answer)
        for answer in currentQuestion.wrong {
            answers.append(answer)
        }
        
        answers.shuffle()
        questionScore = 5
    }
    
    func correct() {
        answeredQuestions.append(currentQuestion.id)
        
        withAnimation {
            gameScore += questionScore
        }
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = gameScore
        saveScore()
        
        gameScore = 0
        activeQuestions = []
        answeredQuestions = []
    }
    
    func saveScore() {
        do {
            let data = try JSONEncoder().encode(recentScores)
            try data.write(to: savePath)
        } catch {
            print("Failed to save score: \(error)")
        }
    }
    
    func loadScore() {
        do {
            let data = try Data(contentsOf: savePath)
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            print("Failed to load score: \(error)")
        }
    }
}
