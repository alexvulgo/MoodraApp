//
//  PageModel.swift
//  MoodraAppVision
//
//  Created by Alessandro Esposito Vulgo Gigante on 05/03/24.
//

import SwiftUI

struct Page: Identifiable, Equatable {
    
    let id = UUID()
    var name : String
    var description : String
    var image : String
    var tag : Int
    
    static var samplePage = Page(name: "Welcome to Moodra!", description: "blablabla", image: "Pataka", tag: 0)
    
    static var pages : [Page] = [
        Page(name: "Welcome to Moodra!", description: "Moodra makes you meditate using mudras, hand gestures from Indian dances and yoga.", image: "mainIcon", tag: 0),
        Page(name: "Learn Mudras", description: "Select your favourite mudras and put your hands in the same position for five seconds, and the app will tell you if you are performing the position correctly!", image: "Tripataka", tag: 1),
        Page(name: "Meditate", description: "Select three mudras and set a timer to meditate. ", image: "Ardhachandra", tag: 2),
        Page(name: "A full immersion experience", description: "Choose your favourite relaxing sound and background to enjoy your dynamic meditation! Note: You need to be in full immersione mode for use the hand tracking.", image: "Main", tag: 3)
    ]
    
    
}


