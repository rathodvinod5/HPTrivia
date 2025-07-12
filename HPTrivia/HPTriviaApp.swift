//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 29/06/25.
//

import SwiftUI

@main
struct HPTriviaApp: App {
    private var game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}
