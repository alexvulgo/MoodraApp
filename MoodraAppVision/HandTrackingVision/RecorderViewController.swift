//
//  RecorderViewController.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 28/02/24.
//

import UIKit

open class RecorderViewController: UIViewController {
    public var recorder: Recorder = {
        var recorder = Recorder()
        return recorder
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recorder.captureSession.startRunning()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recorder.captureSession.stopRunning()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

