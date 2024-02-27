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
        
    Mudra(images: ["Hamsasya", "Hamsasya"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra",
          info: "Info"),
    
    Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra",
          info: "Info"),
    Mudra(images: ["Hamsasya", "Hamsasya"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra",
          info: "Info"),
    Mudra(images: ["Alapadma", "Alapadma"],
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
