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
        
    Mudra(images: ["Pataka", "Pataka"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Pataka",
          info: "Info"),
    
    Mudra(images: ["Tripataka", "Tripataka"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Tripataka",
          info: "Info"),
    Mudra(images: ["Ardhachandra", "Ardhachandra"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Ardhachandra",
          info: "Info"),
    Mudra(images: ["Mushti", "Mushti"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Mushti",
          info: "Info"),
   /* Mudra(images: ["Alapadma", "Alapadma"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Alapadma",
          info: "Info"),
    Mudra(images: ["Hamsasya", "Hamsasya"],
          instructions: ["default-mudra", "default-mudra2"],
          name: "Hamsasya",
          info: "Info")
    */
    ]
    
    
    convenience init(mudras: [Mudra]) {
        self.init()
        self.mudras = mudras
    }
    
    init() {
        
    }
}
