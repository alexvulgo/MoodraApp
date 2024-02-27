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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            dismiss()
        }
    }

    var body: some View {
    
        
        NavigationStack{
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                
                Text("Moodra App")
                    .font(.largeTitle)
                
                Button("Open") {
                    openWindow(id: "mini")
                    dismissWindow()
                   
                }.task {
                   
                }
                
                /*
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                 */
                
                NavigationLink(destination: TutorialView()) {
                   Text("Tutorial")
                        
                }
                
                NavigationLink(destination: SessionView()) {
                    Text("Session")
                        
                }
                .navigationBarTitle("Welcome")
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
