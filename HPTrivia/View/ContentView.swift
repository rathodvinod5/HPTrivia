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
    @State private var scalePlayButton: Bool = false
    @State private var showShowSettings: Bool = false
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
                    
                    HStack {
                        Spacer()
                        
                        InstructionsButton(animateViewsIn: $animateViewsIn, geo: geo)

                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    playGame.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(.brown)
                                        .clipShape(.rect(cornerRadius: 7))
                                        .shadow(radius: 5)
                                        .scaleEffect(scalePlayButton ? 1.2 : 1)
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                                                scalePlayButton.toggle()
                                            }
                                        }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                        
                        Spacer()
                        
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showShowSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.width / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)

                        Spacer()
                    }
                    .frame(width: geo.size.width)

                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewsIn = true
//            playAudio()
        }
    }
    
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
