//
//  MoodraAppVisionApp.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 20/02/24.
//

import SwiftUI

@main
struct MoodraAppVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "mini") { // Identify the window group.
            SessionView() // the SwiftUI view
                .frame(
                    minWidth: 100, maxWidth: 400,
                    minHeight: 100, maxHeight: 400)
        }
       .defaultSize(CGSize(width: 300, height: 150))
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
