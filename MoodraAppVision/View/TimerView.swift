//
//  TimerView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI
import AVKit
import AVFoundation

    struct TimerView : View {
        
        @ObservedObject var timer : SimpleTimer
        @ObservedObject var player: Player
        @Binding var isPresented: Bool
        @Binding var dismissMudraView : Bool
        var timeSelected : Int
        
        //IMMERSIVE SPACE
        
        @Environment(\.openImmersiveSpace) var openImmersiveSpace
        @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
        
        @Binding  var showImmersiveSpace : Bool
        @Binding  var immersiveSpaceIsShown : Bool
        
        var body: some View {
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        Button {
                            self.reset()
                        } label: {
                            Label("Back", systemImage: "chevron.backward")
                                .labelStyle(.iconOnly)
                        }
                        .offset(x: 20, y: -65)
                        

                        Button {
                            //Immersive Space
                            showImmersiveSpace.toggle()
                        } label: {
                            Label("Immersive Space", systemImage: "mountain.2.fill")
                                .labelStyle(.iconOnly)
                        }     .onChange(of: showImmersiveSpace) { _, newValue in
                            Task {
                                if newValue {
                                    switch await openImmersiveSpace(id: "beach") {
                                    case .opened:
                                        immersiveSpaceIsShown = true
                                    case .error, .userCancelled:
                                        fallthrough
                                    @unknown default:
                                        immersiveSpaceIsShown = false
                                        showImmersiveSpace = false
                                    }
                                } else if immersiveSpaceIsShown {
                                    await dismissImmersiveSpace()
                                    immersiveSpaceIsShown = false
                                }
                            }
                        }
                        .offset(x:15, y:-65)
                        
                            Text("\(timer.text)")
                                .font(.system(size: 100))
                                .bold()
                                .padding(.trailing, 60)
                                .frame(width: 340, height: 50)
                            }
                            HStack {
                                Button {
                                    if timer.isMuted {
                                        player.resumeSound()
                                    }
                                    else {
                                        player.pauseSound()
                                    }
                                    timer.isMuted.toggle()
                                } label: {
                                    if(timer.isMuted) {
                                        Label("Mute", systemImage: "speaker.slash.fill")
                                            .labelStyle(.iconOnly)
                                    }
                                    else {
                                        Label("Speaker", systemImage: "speaker.wave.3.fill")
                                            .labelStyle(.iconOnly)
                                    }
                                }
                                .padding(.leading, 12)
                                .padding(.trailing, 10)
                        
                        ProgressView(value: timer.timeRemaining() / Float(timeSelected))
                            .contentShape(.accessibility, Capsule().offset(y: -3))
                            .accessibilityLabel("")
                            .accessibilityValue(Text("5 seconds remaining"))
                            .tint(Color(uiColor: UIColor(red: 242 / 255, green: 68 / 255, blue: 206 / 255, alpha: 1.0)))
                            .padding(.vertical, 30)
                        Button {
                            if(!timer.isPaused){
                                timer.isMuted = true
                                player.pauseSound()
                                timer.stop()
                            }
                            else{
                                timer.start()
                            }
                            timer.isPaused.toggle()
                        } label: {
                            if(timer.isPaused) {
                                Label("Play", systemImage: "play.fill")
                                    .labelStyle(.iconOnly)
                            }
                            else {
                                Label("pause", systemImage: "pause.fill")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .padding(.trailing, 12)
                        .padding(.leading, 10)
                    }
                    .background(
                        .regularMaterial,
                        in: .rect(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 12,
                            bottomTrailingRadius: 12,
                            topTrailingRadius: 0,
                            style: .continuous
                        )
                    )
                    .frame(width: 420, height: 100)
                    .offset(y: 30)
                }
                .padding(.vertical, 12)
                .padding(.top, 64)
            }
            .frame(width: 420, height: 240)
            .onChange(of: timer.isExpired, {if timer.isExpired {self.reset()}})
        }
        
        func reset() {
            self.isPresented = false
            timer.reset(minutes : timeSelected)
            player.stopSound()
            timer.isMuted = true
            dismissMudraView = true
            timer.isExpired = false
        }
    }
