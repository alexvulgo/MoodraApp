//
//  Mudra.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import Foundation

class Mudra: Identifiable {
    var images: [String] = ["default-mudra", "default-mudra2"]
    var instructions: [String] = ["sugg1", "sugg2"]
    
    var name: String = "name"
    var info: String = "Mudra info"
    
    init(images: [String], instructions: [String], name: String, info: String) {
        self.images = images
        self.instructions = instructions
        self.name = name
        self.info = info
    }
}
