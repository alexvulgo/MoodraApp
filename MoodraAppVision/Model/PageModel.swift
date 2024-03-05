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
    
    static var samplePage = Page(name: "Welcome to Moodra!", description: "blablabla", image: "", tag: 0)
    
    static var pages : [Page] = [
        Page(name: "Welcome to Moodra!", description: "Moodra makes you meditate using mudras, hand gestures from Indian dances and yoga.", image: "", tag: 0),
        Page(name: "Learn Mudras", description: "Select your favourite mudras and put your hands in the same position for five seconds, l'app ti dirà se stai eseguendo la posizione correttamente!", image: "", tag: 1),
        Page(name: "Meditate", description: "Select three mudras and set a timer to meditate. ", image: "", tag: 2),
        Page(name: "A full immersion experience", description: "Choose your favourite relaxing sound and background to enjoy your dynamic meditation!", image: "", tag: 3)
    ]
    
    
}


