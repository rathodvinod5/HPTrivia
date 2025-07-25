//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 21/07/25.
//

import SwiftUI
import AVKit

struct Gameplay: View {
    @Environment(Game.self) private var game
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
    
    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!
    @State private var animateViewsIn: Bool = false
    @State private var revealHint: Bool = false
    @State private var revealBook: Bool = false
    @State private var tappedCorrectAnswer: Bool = false
    @State private var wrongAnswersTapped: [String] = []
    @State private var movePointsToScore: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay {
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                
                VStack {
                    // MARK: Controls
                    HStack {
                        Button("End game") {
                            game.endGame()
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        
                        Text("Score: \(game.gameScore)")
                    }
                    .padding()
                    .padding(.vertical, 30)
                    
                    VStack{
                        // MARK: Question
                        VStack {
                            if animateViewsIn {
                                Text(game.currentQuestion.question)
                                    .font(.custom("PartyLetPlain", size: 50))
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .transition(.scale)
                            }
                        }
                        .animation(.easeIn(duration: 2), value: animateViewsIn)
                        
                        Spacer()
                        
                        // MARK: Hints
                        HStack {
                            VStack {
                                if animateViewsIn {
                                    Image(systemName: "questionmark.app.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .foregroundStyle(.cyan)
                                        .padding()
                                        .transition(.offset(x: -geo.size.width / 2))
                                        .phaseAnimator([false, true]) { content, phase in
                                            content
                                                .rotationEffect(.degrees(phase ? -13 : -17))
                                        } animation: { _ in
                                                .easeInOut(duration: 0.7)
                                        }
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                revealHint = true
                                            }
                                            
                                            playFlipSound()
                                            game.gameScore -= 1
                                        }
                                        .rotation3DEffect(.degrees(revealHint ? 1440 : 0), axis: (x: 0, y: 1, z: 0))
                                        .scaleEffect(revealHint ? 5 : 1)
                                        .offset(x: revealHint ? geo.size.width/2 : 0)
                                        .opacity(revealHint ? 0 : 1)
                                        .overlay {
                                            Text(game.currentQuestion.hint)
                                                .padding(.leading, 20)
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .opacity(revealHint ? 1 : 0)
                                                .scaleEffect(revealHint ? 1.33 : 1)
                                        }
                                }
                            }
                            .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                            
                            Spacer()
                            
                            VStack {
                                if animateViewsIn {
                                    Image(systemName: "app.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .foregroundStyle(.cyan)
                                        .overlay(content: {
                                            Image(systemName: "book.closed")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50)
                                                .foregroundStyle(.black)
                                        })
                                        .padding()
                                        .transition(.offset(x: geo.size.width / 2))
                                        .phaseAnimator([false, true]) { content, phase in
                                            content
                                                .rotationEffect(.degrees(phase ? 13 : 17))
                                        } animation: { _ in
                                                .easeInOut(duration: 0.7)
                                        }
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 1)) {
                                                revealBook = true
                                            }
                                            
                                            playFlipSound()
                                            game.gameScore -= 1
                                        }
                                        .rotation3DEffect(.degrees(revealBook ? -1440 : 0), axis: (x: 0, y: 1, z: 0))
                                        .scaleEffect(revealBook ? 5 : 1)
                                        .offset(x: revealBook ? -geo.size.width/2 : 0)
                                        .opacity(revealBook ? 0 : 1)
                                        .overlay {
                                            Image("hp\(game.currentQuestion.book)")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(.trailing, 20)
                                                .opacity(revealBook ? 1 : 0)
                                                .scaleEffect(revealBook ? 1.33 : 1)
                                        }
                                }
                            }
                            .animation(.easeOut(duration: 1.5).delay(2), value: animateViewsIn)
                        }
                        .padding()
                        
                        // MARK: Answers
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(game.answers, id: \.self) { answer in
                                if answer == game.currentQuestion.answer {
                                    // MARK: Correct answer
                                    VStack {
                                        if animateViewsIn {
                                            if !tappedCorrectAnswer {
                                                Button {
                                                    withAnimation(.easeInOut(duration: 1)) {
                                                        tappedCorrectAnswer = true
                                                    }
                                                    playCorrectSound()
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                                        game.correct()
                                                    }
                                                    
                                                } label: {
                                                    Text(answer)
                                                        .minimumScaleFactor(0.5)
                                                        .multilineTextAlignment(.center)
                                                        .padding()
                                                        .frame(width: geo.size.width/2.15, height: 80)
                                                        .background(.green.opacity(0.5))
                                                        .cornerRadius(20)
                                                        .matchedGeometryEffect(id: 1, in: namespace)
                                                }
                                                .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 15).combined(with: .opacity)))
                                            }
                                        }
                                    }
                                    .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                                } else {
                                    // MARK: Wrong answer
                                    VStack {
                                        if animateViewsIn {
                                            Button {
                                                withAnimation(.easeInOut(duration: 1)) {
                                                    wrongAnswersTapped.append(answer)
                                                }
                                                
                                                playWrongSound()
                                                game.gameScore -= 1
                                            } label: {
                                                Text(answer)
                                                    .minimumScaleFactor(0.5)
                                                    .multilineTextAlignment(.center)
                                                    .padding()
                                                    .frame(width: geo.size.width/2.15, height: 80)
                                                    .background(
                                                        wrongAnswersTapped.contains(answer)
                                                        ? .red.opacity(0.5)
                                                        : .green.opacity(0.5))
                                                    .cornerRadius(20)
                                                    .scaleEffect(wrongAnswersTapped.contains(answer) ? 0.8 : 1)
                                            }
                                            .disabled(wrongAnswersTapped.contains(answer))
                                        }
                                    }
                                    .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .disabled(tappedCorrectAnswer)
                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)
                
                
                // MARK: Celebrations
                VStack {
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("\(game.questionScore)")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                                .padding(.top, 50)
                                .transition(.offset(y: -geo.size.height / 2))
                                .offset(x: movePointsToScore ? geo.size.width / 2.3 : 0,
                                        y: movePointsToScore ? -geo.size.height / 13 : 0)
                                .opacity(movePointsToScore ? 0 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 3).delay(3)) {
                                        movePointsToScore = true
                                    }
                                }
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(2), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliant")
                                .foregroundStyle(.white)
                                .font(.custom("PartyLetPlain", size: 100))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height / 2)))
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(1), value: tappedCorrectAnswer)
                    
                    Spacer()
                    
                    if tappedCorrectAnswer {
                        Text(game.currentQuestion.answer)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: geo.size.width/2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .cornerRadius(20)
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: 1, in: namespace)
                    }
                    
                    Spacer()
                    Spacer()
                    
                    VStack {
                        if tappedCorrectAnswer {
                            Button("Next Level >") {
                                
                            }
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                                .buttonStyle(.borderedProminent)
                                .tint(.blue.opacity(0.5))
                        }
                    }
                    .animation(.easeInOut(duration: 2).delay(2.7), value: tappedCorrectAnswer)
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .scaleEffect(phase ? 1.2 : 1)
                    } animation: { _ in
                            .easeInOut(duration: 1.3)
                    }

                    
                    Spacer()
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            game.startGame()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                animateViewsIn.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                playMusic()
            }
        }
    }
    
    private func playMusic() {
        let sounds = ["let-the-mistory-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
        let song = sounds.randomElement()!
        let sound = Bundle.main.path(forResource: song, ofType: "mp3")
        
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        musicPlayer.numberOfLoops = -1
        musicPlayer.volume = 0.1
        musicPlayer.play()
    }
    
    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
    
    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
    
    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        sfxPlayer.play()
    }
}

#Preview {
    Gameplay()
        .environment(Game())
}
