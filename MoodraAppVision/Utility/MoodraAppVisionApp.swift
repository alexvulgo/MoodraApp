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

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
