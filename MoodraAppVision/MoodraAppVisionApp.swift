import SwiftUI

@main
struct MoodraAppVisionApp: App {

    @State var selectedMudra : [Mudra] = []
    @State var count : Int = 0
    @State var dismissMudraView = false
    
    @State var showImmersiveSpace = false
    @State var immersiveSpaceIsShown = false
    @State var soundSelected = "Calm Sea"

    
    var body: some Scene {
        WindowGroup (id: "main"){
            ContentView(soundSelected: $soundSelected, showImmersiveSpace: $showImmersiveSpace, immersiveSpaceIsShown: $immersiveSpaceIsShown)
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "session") { // Identify the window group.
            SessionView(dismissMudraView: $dismissMudraView,showImmersiveSpace: $showImmersiveSpace, immersiveSpaceIsShown: $immersiveSpaceIsShown, soundSelected :$soundSelected) // the SwiftUI view
        }
       .defaultSize(CGSize(width: 420, height: 240))
        
        WindowGroup(id: "tutorial"){
            TutorialView(selectedMudra: $selectedMudra, dismissMudraView: $dismissMudraView, showImmersiveSpace: $showImmersiveSpace, immersiveSpaceIsShown: $immersiveSpaceIsShown)
                }
                .defaultSize(CGSize(width: 420, height: 360))
        
        WindowGroup(id: "mudra"){
            MudraView(mudra: $selectedMudra,count: $count, dismissView: $dismissMudraView)
                }
                .defaultSize(CGSize(width: 300, height: 500))
         
        WindowGroup (id: "mudraSelectionTutorial"){
            MudraSelectionView(selectedMudra: $selectedMudra, dismissMudraView: $dismissMudraView, tutorialMode: true, showImmersiveSpace: $showImmersiveSpace, immersiveSpaceIsShown: $immersiveSpaceIsShown)
        }
        .windowResizability(.contentSize)
        
        WindowGroup (id: "mudraSelectionSession"){
            MudraSelectionView(selectedMudra: $selectedMudra, dismissMudraView: $dismissMudraView, tutorialMode: false, showImmersiveSpace: $showImmersiveSpace, immersiveSpaceIsShown: $immersiveSpaceIsShown)
        }
        .windowResizability(.contentSize)
        
/*
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
 */
        
#if os(visionOS)
        // Defines an immersive space to present a destination in which to watch the video.
        ImmersiveSpace(id: "beach") {
            DestinationView(.beach)
        }
        // Set the immersion style to progressive, so the user can use the crown to dial in their experience.
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
#endif
    }
}
