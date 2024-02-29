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
          name: "Mudra 1",
          info: "Info"),
    
    Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra 2",
          info: "Info"),
    Mudra(images: ["Hamsasya", "Hamsasya"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra 3",
          info: "Info"),
    Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra 4",
          info: "Info"),
    Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra 5",
          info: "Info"),
    Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mudra 6",
          info: "Info")
    
    ]
    
    
    convenience init(mudras: [Mudra]) {
        self.init()
        self.mudras = mudras
    }
    
    init() {
        
    }
}
