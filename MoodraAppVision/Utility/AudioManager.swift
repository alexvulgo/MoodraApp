//
//  AudioManager.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 01/03/24.
//

import Combine
import AVFAudio

class Player: ObservableObject {
    
    var sound: AVAudioPlayer!
    
    let willChange = PassthroughSubject<Player, Never>()
    
    var isPlaying: Bool = false {
        willSet {
            willChange.send(self)
        }
    }
    
    func playSound(soundName : String, soundType: String) {
        
        if let path = Bundle.main.path(forResource: soundName, ofType: soundType) {
            do {
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                print("Playing sound")
                sound.play()
            } catch {
                print( "Could not find file")
            }
        }
    }
    
    func resumeSound() {
        sound.play()
    }
    
    func pauseSound() {
        sound.pause()
    }
    
    func stopSoud() {
        sound.stop()
    }
}
