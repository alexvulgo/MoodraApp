import SwiftUI

@main
struct MoodraAppVisionApp: App {

    @State var selectedMudra : [Mudra] = []
    
    var body: some Scene {
        WindowGroup (id: "main"){
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "session") { // Identify the window group.
            SessionView() // the SwiftUI view
        }
       .defaultSize(CGSize(width: 420, height: 240))
        
        WindowGroup(id: "tutorial"){
            TutorialView(selectedMudra: $selectedMudra)
                }
                .defaultSize(CGSize(width: 1300, height: 360))
        
        WindowGroup(id: "mudra"){
            MudraView()
                }
                .defaultSize(CGSize(width: 300, height: 500))
         
        WindowGroup (id: "mudraSelectionTutorial"){
            MudraSelectionView(selectedMudra: $selectedMudra, tutorialMode: true)
        }
        .windowResizability(.contentSize)
        
        WindowGroup (id: "mudraSelectionSession"){
            MudraSelectionView(selectedMudra: $selectedMudra, tutorialMode: false)
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
