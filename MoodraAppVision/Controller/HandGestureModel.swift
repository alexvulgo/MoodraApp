//
//  HandGestureModel.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 22/02/24.
//
import ARKit
import SwiftUI

/// A model that contains up-to-date hand coordinate information.
@MainActor
class HeartGestureModel: ObservableObject, @unchecked Sendable {
    let session = ARKitSession()
    var handTracking = HandTrackingProvider()
    @Published var latestHandTracking: HandsUpdates = .init(left: nil, right: nil)
    
    struct HandsUpdates {
        var left: HandAnchor?
        var right: HandAnchor?
    }
    
    func start() async {
        do {
            if HandTrackingProvider.isSupported {
                print("ARKitSession starting.")
                try await session.run([handTracking])
            }
        } catch {
            print("ARKitSession error:", error)
        }
    }
    
    func publishHandTrackingUpdates() async {
        for await update in handTracking.anchorUpdates {
            switch update.event {
            case .updated:
                let anchor = update.anchor
                
                // Publish updates only if the hand and the relevant joints are tracked.
                guard anchor.isTracked else { continue }
                
                // Update left hand info.
                if anchor.chirality == .left {
                    latestHandTracking.left = anchor
                } else if anchor.chirality == .right { // Update right hand info.
                    latestHandTracking.right = anchor
                }
            default:
                break
            }
        }
    }
    
    func monitorSessionEvents() async {
        for await event in session.events {
            switch event {
            case .authorizationChanged(let type, let status):
                if type == .handTracking && status != .allowed {
                    // Stop the game, ask the user to grant hand tracking authorization again in Settings.
                }
            default:
                print("Session event \(event)")
            }
        }
    }
    
    /// Computes a transform representing the heart gesture performed by the user.
    ///
    /// - Returns:
    ///  * A right-handed transform for the heart gesture, where:
    ///     * The origin is in the center of the gesture
    ///     * The X axis is parallel to the vector from left thumb knuckle to right thumb knuckle
    ///     * The Y axis is parallel to the vector from right thumb tip to right index finger tip.
    ///  * `nil` if either of the hands isn't tracked or the user isn't performing a heart gesture
    ///  (the index fingers and thumbs of both hands need to touch).
    func computeTransformOfUserPerformedHeartGesture() -> simd_float4x4? {
        // Get the latest hand anchors, return false if either of them isn't tracked.
        guard let leftHandAnchor = latestHandTracking.left,
              let rightHandAnchor = latestHandTracking.right,
              leftHandAnchor.isTracked, rightHandAnchor.isTracked else {
            return nil
        }
        
        // Get all required joints and check if they are tracked.
        guard
            //Middle Finger
            let leftHandMiddleKnuckle = leftHandAnchor.handSkeleton?.joint(.middleFingerKnuckle),
            let rightHandMiddleKnuckle = rightHandAnchor.handSkeleton?.joint(.middleFingerKnuckle),
            
            let leftHandMiddleTip = leftHandAnchor.handSkeleton?.joint(.middleFingerTip),
            let rightHandMiddleTip = rightHandAnchor.handSkeleton?.joint(.middleFingerTip),
            
            let leftHandMiddleIntermediateTip = leftHandAnchor.handSkeleton?.joint(.middleFingerIntermediateTip),
            let rightHandMiddleIntermediateTip = rightHandAnchor.handSkeleton?.joint(.middleFingerIntermediateTip),
            
            //Ring Finger
            let leftHandRingKnuckle = leftHandAnchor.handSkeleton?.joint(.ringFingerKnuckle),
            let rightHandRingKnuckle = rightHandAnchor.handSkeleton?.joint(.ringFingerKnuckle),
            
            let leftHandRingTip = leftHandAnchor.handSkeleton?.joint(.ringFingerTip),
            let rightHandRingTip = rightHandAnchor.handSkeleton?.joint(.ringFingerTip),
            
            let leftHandRingIntermediateTip = leftHandAnchor.handSkeleton?.joint(.ringFingerIntermediateTip),
            let rightHandRingIntermediateTip = rightHandAnchor.handSkeleton?.joint(.ringFingerIntermediateTip),
            
            //Little Finger
            let leftHandLittleKnuckle = leftHandAnchor.handSkeleton?.joint(.littleFingerKnuckle),
            let rightHandLittleKnuckle = rightHandAnchor.handSkeleton?.joint(.littleFingerKnuckle),
            
            let leftHandLittleTip = leftHandAnchor.handSkeleton?.joint(.littleFingerTip),
            let rightHandLittleTip = rightHandAnchor.handSkeleton?.joint(.littleFingerTip),
            
            let leftHandLittleIntermediateTip = leftHandAnchor.handSkeleton?.joint(.littleFingerIntermediateTip),
            let rightHandLittleIntermediateTip = rightHandAnchor.handSkeleton?.joint(.littleFingerIntermediateTip),
            
            //Thumb
            let leftHandThumbKnuckle = leftHandAnchor.handSkeleton?.joint(.thumbKnuckle),
            let rightHandThumbKnuckle = rightHandAnchor.handSkeleton?.joint(.thumbKnuckle),

            let leftHandThumbTipPosition = leftHandAnchor.handSkeleton?.joint(.thumbTip),
            let rightHandThumbTipPosition = rightHandAnchor.handSkeleton?.joint(.thumbTip),
            
            let leftHandThumpIntermediateTip = leftHandAnchor.handSkeleton?.joint(.thumbIntermediateTip),
            let rightHandThumbIntermediateTip = rightHandAnchor.handSkeleton?.joint(.thumbIntermediateTip),
            
            //Index
            let leftHandIndexKnuckle = leftHandAnchor.handSkeleton?.joint(.indexFingerKnuckle),
            let rightHandIndexKnuckle = rightHandAnchor.handSkeleton?.joint(.indexFingerKnuckle),
            
            let rightHandIndexFingerTip = rightHandAnchor.handSkeleton?.joint(.indexFingerTip),
            let leftHandIndexFingerTip = leftHandAnchor.handSkeleton?.joint(.indexFingerTip),
            
            let leftHandIndexIntermediateTip = leftHandAnchor.handSkeleton?.joint(.indexFingerIntermediateTip),
            let rightHandIndexIntermediateTip = rightHandAnchor.handSkeleton?.joint(.indexFingerIntermediateTip),
            
                
            //Tracking check
            leftHandIndexFingerTip.isTracked && leftHandThumbTipPosition.isTracked &&
                rightHandIndexFingerTip.isTracked && rightHandThumbTipPosition.isTracked &&
                leftHandThumbKnuckle.isTracked && rightHandThumbKnuckle.isTracked
        else {
            return nil
        }
        
        // Get the position of all joints in world coordinates.
        
        //Left Hand Knuckles
        let originFromLeftHandThumbKnuckleTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandThumbKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromLeftHandIndexKnuckleTransform = matrix_multiply(leftHandAnchor.originFromAnchorTransform, leftHandIndexKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromLeftHandMiddleKnuckleTransform = matrix_multiply(leftHandAnchor.originFromAnchorTransform, leftHandMiddleKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromLeftHandRingKnuckleTransform = matrix_multiply(leftHandAnchor.originFromAnchorTransform, leftHandRingKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromLeftHandLittleKnuckleTransform = matrix_multiply(leftHandAnchor.originFromAnchorTransform, leftHandLittleKnuckle.anchorFromJointTransform).columns.3.xyz
        
        //Left Hand Tips
        let originFromLeftHandThumbTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandThumbTipPosition.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandIndexFingerTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandIndexFingerTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandMiddleFingerTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandMiddleTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandRingFingerTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandRingTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandLittleFingerTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandLittleTip.anchorFromJointTransform
        ).columns.3.xyz
        
        //Left Hand Intermediate Tips
        let originFromLeftHandThumbIntermediateTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandThumpIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandIndexFingerIntermediateTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandIndexIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandMiddleIntermediateTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandMiddleIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandRingIntermediateTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandRingIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromLeftHandLittleIntermediateTipTransform = matrix_multiply(
            leftHandAnchor.originFromAnchorTransform, leftHandLittleIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        
        
        //Right Hand Knuckles
        let originFromRightHandThumbKnuckleTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandThumbKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromRightHandIndexKnuckleTransform = matrix_multiply(rightHandAnchor.originFromAnchorTransform, rightHandIndexKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromRightHandMiddleKnuckleTransform = matrix_multiply(rightHandAnchor.originFromAnchorTransform, rightHandMiddleKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromRightHandRingKnuckleTransform = matrix_multiply(rightHandAnchor.originFromAnchorTransform, rightHandRingKnuckle.anchorFromJointTransform).columns.3.xyz
        let originFromRigtHandLittleKnuckleTransform = matrix_multiply(rightHandAnchor.originFromAnchorTransform, rightHandLittleKnuckle.anchorFromJointTransform).columns.3.xyz
        
        //Right Hand Tips
        let originFromRightHandThumbTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandThumbTipPosition.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandIndexFingerTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandIndexFingerTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandMiddleFingerTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandMiddleTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandRingFingerTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandRingTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandLittleFingerTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandLittleTip.anchorFromJointTransform
        ).columns.3.xyz
        
        //Right Hand Intermediate Tips
        let originFromRightHandThumbIntermediateTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandThumbIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandIndexIntermediateTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandIndexIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandMiddleIntermediateTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandMiddleIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandRingIntermediateTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandRingIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        let originFromRightHandLittleIntermediateTipTransform = matrix_multiply(
            rightHandAnchor.originFromAnchorTransform, rightHandLittleIntermediateTip.anchorFromJointTransform
        ).columns.3.xyz
        
        
        //Old Distances
        let indexFingersDistance = distance(originFromLeftHandIndexFingerTipTransform, originFromRightHandIndexFingerTipTransform)
        let thumbsDistance = distance(originFromLeftHandThumbTipTransform, originFromRightHandThumbTipTransform)
        
        //New Distances
        
        
        // Heart gesture detection is true when the distance between the index finger tips centers
        // and the distance between the thumb tip centers is each less than four centimeters.
        let isHeartShapeGesture = indexFingersDistance < 0.04 && thumbsDistance < 0.04
        if !isHeartShapeGesture {
            return nil
        }
        
        // Compute a position in the middle of the heart gesture.
        let halfway = (originFromRightHandIndexFingerTipTransform - originFromLeftHandThumbTipTransform) / 2
        let heartMidpoint = originFromRightHandIndexFingerTipTransform - halfway
        
        // Compute the vector from left thumb knuckle to right thumb knuckle and normalize (X axis).
        let xAxis = normalize(originFromRightHandThumbKnuckleTransform - originFromLeftHandThumbKnuckleTransform)
        
        // Compute the vector from right thumb tip to right index finger tip and normalize (Y axis).
        let yAxis = normalize(originFromRightHandIndexFingerTipTransform - originFromRightHandThumbTipTransform)
        
        let zAxis = normalize(cross(xAxis, yAxis))
        
        // Create the final transform for the heart gesture from the three axes and midpoint vector.
        let heartMidpointWorldTransform = simd_matrix(
            SIMD4(xAxis.x, xAxis.y, xAxis.z, 0),
            SIMD4(yAxis.x, yAxis.y, yAxis.z, 0),
            SIMD4(zAxis.x, zAxis.y, zAxis.z, 0),
            SIMD4(heartMidpoint.x, heartMidpoint.y, heartMidpoint.z, 1)
        )
        return heartMidpointWorldTransform
    }
}