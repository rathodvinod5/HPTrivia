//
//  ContentView.swift
//  HPTrivia
//
//  Created by Vinod Rathod on 29/06/25.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var animateViewsIn = false
    @State private var audioPlayer: AVAudioPlayer!
    @State private var playGame: Bool = false

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AnimatedBackground(geo: geo)

                VStack {
                    GameTemplate(animateViewsIn: $animateViewsIn)
                    
                    Spacer()
                    
                    RecentScores(animateViewsIn: $animateViewsIn)
                    
                    Spacer()
                    
                    ButtonBar(animateViewsIn: $animateViewsIn, playGame: $playGame, geo: geo)

                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewsIn = true
            playAudio()
        }
        .fullScreenCover(isPresented: $playGame) {
            Gameplay()
                .onAppear {
                    audioPlayer.setVolume(0, fadeDuration: 2)
                }
                .onDisappear {
                    audioPlayer.setVolume(1, fadeDuration: 3)
                }
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer.numberOfLoops = -1
//        audioPlayer.play()
    }
}

#Preview {
    ContentView()
        .environment(Game())
}
