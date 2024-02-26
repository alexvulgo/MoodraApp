//
//  MudraViewModel.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import Foundation

class MudraViewModel {
    static let shared = MudraViewModel()
    
    var mudras: [Mudra] = [
    Mudra(images: ["default-mudra", "default-mudra2"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra",
          info: "Info"),
    Mudra(images: ["default-mudra", "default-mudra2"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra",
          info: "Info")
    ]
    
    
    convenience init(mudras: [Mudra]) {
        self.init()
        self.mudras = mudras
    }
    
    init() {
        
    }
}