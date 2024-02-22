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

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var startASession = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationStack{
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                
                Text("Moodra App")
                    .font(.largeTitle)
                /*
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                 */
                
                NavigationLink(destination: TutorialView()) {
                   Text("Tutorial")
                        .onTapGesture {
                            showImmersiveSpace = true
                        }
                }
                
                NavigationLink(destination: SessionView()) {
                    Text("Session")
                        .onTapGesture {
                            showImmersiveSpace = true
                        }
                }
                .navigationBarTitle("Welcome")
            }
               
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
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
