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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(.hogwarts)
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .phaseAnimator([false, true]) { content, phase in
                        content
                            .offset(x: phase ? geo.size.width / 1.1 : -geo.size.width / 1.1)
                    } animation: { _ in
                            .linear(duration: 60)
                    }

                VStack {
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .imageScale(.large)
                                    .font(.largeTitle)
                                Text("HP")
                                    .font(.custom("PartyLetPlain", size: 70))
                                    .padding(.bottom, -50)
                                Text("Trivia")
                                    .font(.custom("PartyLetPlain", size: 60))
                            }
                            .padding(.top, 70)
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    VStack {
                        if animateViewsIn {
                            Button {
                                
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
