//
//  ContentView.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 20/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct ContentView: View {
    
    private var viewModel = MudraViewModel()
    @State var val = 0

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var startASession = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismiss

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    func dismissWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            dismiss()
        }
    }

    var body: some View {
    
        NavigationStack{
            VStack {
                
                ZStack{
                    Circle()
                        .fill(Color.white)
                        .frame(width: 222, height: 222)
                   
                    Image("Main")
                        .resizable()
                        .frame(width: 222, height: 222)
                    
                }
                
                VStack{
                    
                    Text("Moodra: Meditate with Mudras")
                        .font(.system(size: 40))
                        .bold()
                        .frame(width: 860, height: 60)
                    
                    Text("Start your meditation session with mudras.")
                        .font(.system(size: 32))
                        .frame(width: 853, height: 20)
                    
                }
                .padding()
                
                /*
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                 */
                
                /*NavigationLink(destination: MudraSelectionView(tutorialMode: true)) {
                   Text("Learn Mudras")
                }*/
                
                VStack {
                    Button("Learn Mudras"){
                        openWindow(id : "mudraSelectionTutorial")
                        dismissWindow()
                    }
                    .foregroundStyle(.black)
                    .tint(.white)
                    .frame(width: 177, height: 52)
                    .padding(.bottom, 5)
                    
                    Button("Meditate"){
                        showImmersiveSpace = true
                        openWindow(id : "mudraSelectionSession")
                        dismissWindow()
                    }
                    .foregroundStyle(.black)
                    .tint(.white)
                    .frame(width: 132, height: 52)
                }
                .padding()
                
                //.navigationBarTitle("Welcome")
                
               /* NavigationLink(destination: MudraSelectionView(tutorialMode: false)) {
                    Text("Meditate")
                }
                .navigationBarTitle("Welcome")*/
            }
               
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
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
    }
    
    func startMeditationSession(){
        print("starting a meditation session")
        startASession = true
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
