//
//  TimerUtil.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import Foundation
import SwiftUI
import AVFAudio

class SimpleTimer : ObservableObject{
    
    private var timer: Timer?
    
    private var minutes = 5
    private var seconds = 0
    @Published var text = "05:00"
    @Published var isPaused = false
    @Published var isMuted = false
    @Published var isExpired = false
    private var action: (() -> Void)
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func start() {
        // Invalidate the timer if it's already running
        timer?.invalidate()
                
        // Schedule a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateSeconds()
            self?.updateText()
        }
    }
    
    func set_timer(setMinutes : Int, setSeconds: Int) {
        self.minutes = setMinutes
        self.seconds = setSeconds
        text = "\(String(format: "%02d", self.minutes)):\(String(format: "%02d", self.seconds))"
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset(minutes : Int) {
        self.stop()
        self.minutes = minutes
        self.seconds = 0
        self.updateText()
    }
    
    func updateSeconds() {
        if seconds > 0 {
            seconds -= 1
        }
        else {
            self.updateMinutes()
        }
    }
    
    func updateMinutes() {
        if minutes > 0 {
            minutes -= 1
            seconds = 59
        }
        else{
            self.stop()
        }
    }
    
    func updateText() {
        text = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    }
    
    func timeRemaining() -> Float {
        //print("\(String(format: "%f", Float(minutes) + Float(seconds) / 100))")
        if (Float(minutes) + Float(seconds) / 100) == 0 {
            self.isExpired = true
        }
        
        return Float(minutes) + Float(seconds) / 100
    }
    
    deinit {
        // Make sure the timer is stopped if the object is deallocated
        stop()
    }
}


