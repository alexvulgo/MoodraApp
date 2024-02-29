//
//  TutorialView.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }.navigationTitle("Tutorial")
        .frame(minWidth: 1000, maxHeight: 150)
        .scaledToFill()
        .scaleEffect(1.9)
    }
}

#Preview {
    TutorialView()
}
