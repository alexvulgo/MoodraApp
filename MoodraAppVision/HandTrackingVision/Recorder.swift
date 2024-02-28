//
//  Recorder.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 28/02/24.
//
import UIKit
import AVFoundation

open class Recorder: NSObject {
    public typealias VideoListener = (URL) -> ()
    public typealias SampleBufferListener = (AVCaptureOutput, CMSampleBuffer, AVCaptureConnection) -> ()

    
    public var videoListeners: [VideoListener] = [VideoListener]()
    public var sampleBufferListeners: [SampleBufferListener] = [SampleBufferListener]()
   
    
    public private(set) var isRecording: Bool = false
    public var captureSession: AVCaptureSession = AVCaptureSession()
    
    private var assetWriter: AVAssetWriter? = nil
    private var audioInput: AVAssetWriterInput? = nil
    private var videoInput: AVAssetWriterInput? = nil
    
    private var startTime: CMTime = CMTime.invalid
    private var duration: CMTime = CMTime.zero
    
    private var lastVideoSampleBuffer: CMSampleBuffer? = nil
    
    public var isFacingFront: Bool = true {
        didSet {
            self.setupInputs()
        }
    }
    
    public override init() {
        super.init()
        openCamera()
    }
    
    private func openCamera() {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let audioAuthStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        if videoAuthStatus == .authorized && audioAuthStatus == .authorized {
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.videoSettings = [
                //String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
                String(kCVPixelBufferPixelFormatTypeKey) : Int(kCVPixelFormatType_32BGRA)
            ]
            videoOutput.alwaysDiscardsLateVideoFrames = false
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            } else {
                print("can't add video output")
            }
            
           
          
           
            
            setupInputs()
            
            let queue = DispatchQueue(label: "recorder.queue")
            
        
            
          
           
           
            
            captureSession.startRunning()
        } else if videoAuthStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera()
                    }
                }
            }
        } else if videoAuthStatus == .authorized && audioAuthStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.openCamera()
                    }
                }
            })
        }
    }
    
    private func setupInputs() {
        print(#function)
       
    }
    
    public func startRecording() {
        /*
         print(#function)
         if !isRecording {
         let outputURL = URL(fileURLWithPath: NSTemporaryDirectory().appending(UUID().uuidString).appending(".mp4"))
         do {
         assetWriter = try AVAssetWriter(outputURL: outputURL, fileType: .mp4)
         } catch {
         print(error)
         }
         assetWriter!.shouldOptimizeForNetworkUse = true
         let videoSettings: [String: Any] = [AVVideoCodecKey: AVVideoCodecType.h264, AVVideoHeightKey: 800, AVVideoWidthKey: 450]
         videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
         videoInput!.expectsMediaDataInRealTime = true
         if assetWriter!.canAdd(videoInput!) {
         assetWriter!.add(videoInput!)
         } else {
         videoInput = nil
         print("recorder, could not add video input to session")
         }
         let audioSettings: [String: Any] = [AVFormatIDKey: kAudioFormatMPEG4AAC, AVSampleRateKey: 44100.0, AVNumberOfChannelsKey: 1]
         audioInput = AVAssetWriterInput(mediaType: .audio, outputSettings: audioSettings)
         audioInput!.expectsMediaDataInRealTime = true
         if assetWriter!.canAdd(audioInput!) {
         assetWriter!.add(audioInput!)
         } else {
         audioInput = nil
         print("recorder, could not add audio input to session")
         }
         isRecording = assetWriter!.startWriting()
         }
         */
    }
    
    public func stopRecording() {
        /*print(#function)
         if isRecording {
         if startTime.isValid {
         isRecording = false
         videoInput?.markAsFinished()
         audioInput?.markAsFinished()
         assetWriter!.endSession(atSourceTime: duration + startTime)
         startTime = CMTime.invalid
         duration = CMTime.zero
         assetWriter!.finishWriting {
         DispatchQueue.main.async {
         for listener in self.videoListeners {
         listener(self.assetWriter!.outputURL)
         }
         }
         }
         }
         else {
         //if the recording has started, but startSession has not yet been called, repeat this method with a slight pause
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
         self.stopRecording()
         }
         }
         }
         }
         
         public func takePhoto() -> UIImage? {
         if lastVideoSampleBuffer != nil {
         let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(lastVideoSampleBuffer!)!
         
         let ciimage : CIImage = CIImage(cvPixelBuffer: imageBuffer)
         
         let image : UIImage = self.convert(cmage: ciimage)
         return image
         }
         
         return nil
         */
    }
    
    // Convert CIImage to CGImage
    func convert(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    deinit {
        print(#function)
    }
}

extension Recorder {
    open func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        for listener in sampleBufferListeners {
            listener(output, sampleBuffer, connection)
        }
        if output is AVCaptureVideoDataOutput {
            lastVideoSampleBuffer = sampleBuffer
        }
        if self.isRecording {
            let timestamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            if !startTime.isValid && output is AVCaptureVideoDataOutput {
                startTime = timestamp
                assetWriter!.startSession(atSourceTime: startTime)
            }
            if startTime.isValid {
                if output is AVCaptureVideoDataOutput {
                    if videoInput != nil && videoInput!.isReadyForMoreMediaData {
                        videoInput!.append(sampleBuffer)
                        duration = timestamp - startTime
                    }
                }
            }
        }
    }
    
  
}


