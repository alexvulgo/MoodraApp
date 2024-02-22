//
//  TimerUtil.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//

import Foundation

class SimpleTimer {
    private var timer: Timer?
    private var interval: TimeInterval
    private var action: (() -> Void)
    
    init(interval: TimeInterval, action: @escaping () -> Void) {
        self.interval = interval
        self.action = action
    }
    
    func start() {
        // Invalidate the timer if it's already running
        timer?.invalidate()
        
        // Schedule a new timer
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.action()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        // Make sure the timer is stopped if the object is deallocated
        stop()
    }
}

