//
//  SessionView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct SessionView: View {
    
    @ObservedObject var timer : SimpleTimer = SimpleTimer(action: {})
    @ObservedObject var player : Player = Player()
    @State private var isPresentingTimerView = false
    let settings = [5, 10, 15, 20, 25, 30]
    @State var selectedOption = 5
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }
    
    var body: some View {
        
        if !isPresentingTimerView {
            
            HStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        
                        
                        Button {
                            openWindow(id: "mudraSelectionSession")
                            dismissWindow()
                        } label: {
                            Label("Back", systemImage: "chevron.backward")
                                .labelStyle(.iconOnly)
                        }
                        .offset(x: -48)
                        
                        
                        
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
                        .offset(x:-53)
                        
                    }.padding(.trailing, 200)
                        .frame(width: 270, height: 40)
                    
                    
                    HStack(){
                        
                        Spacer()
                        
                        Text("Start session")
                            .font(.system(size: 35))
                            .bold()
                            .frame(width: 270, height: 40)
                            .offset(y:10)
                        
                        Spacer()
                    }
                    
                    Text("Take some of your time to meditate by focusing on the movement of your hands.")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 50)
                        .padding()
                
                    HStack{
                        
                        Picker("Select an Option", selection: $selectedOption) {
                            ForEach(0..<settings.count) { index in
                                Text((String(format: "%d min", settings[index]))).tag(settings[index])
                            }
                        }
                        
                        Button("Start") {
                            isPresentingTimerView.toggle()
                            timer.start()
                            player.playSound(soundName: "calmSea", soundType: "mp3")
                            openWindow(id: "mudra")
                        }
                       
                    }.onChange(of: selectedOption, {timer.set_timer(setMinutes: selectedOption)})
                        .frame(width: 420 ,height: 50)
                }.padding(.vertical, 12)
            }.frame(width: 420, height: 240)
        }
        else{
            TimerView(timer: timer, player: player, isPresented: $isPresentingTimerView, timeSelected: selectedOption)
                .glassBackgroundEffect(
                in: RoundedRectangle(
                    cornerRadius: 32,
                    style: .continuous
                )
            )
        }
    }
}

#Preview {

    SessionView().glassBackgroundEffect(
        in: RoundedRectangle(
            cornerRadius: 32,
            style: .continuous
        )
    )
}

#Preview {

    SessionView().glassBackgroundEffect(
        in: RoundedRectangle(
            cornerRadius: 32,
            style: .continuous
        )
    )
}
