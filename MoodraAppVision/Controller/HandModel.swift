//
//  HandModel.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 29/02/24.
//

import Foundation


class HandModel {
    var thumb: FingerModel = FingerModel()
    var index: FingerModel = FingerModel()
    var middle: FingerModel = FingerModel()
    var ring: FingerModel = FingerModel()
    var little: FingerModel = FingerModel()
    
    var thumbTipKnuckleDistance = 30.0
    var indexTipKnuckleDistance = 30.0
    var middleTipKnuckleDistance = 30.0
    var ringTipKnuckleDistance = 30.0
    var littleTipKnuckleDistance = 30.0
    
    var thumbIntermediateTipKnuckleDistance = 30.0
    var indexIntermediateTipKnuckleDistance = 30.0
    var middleintermediateTipKnuckleDistance = 30.0
    var ringIntermediateTipKnuckleDistance = 30.0
    var littleIntermediateTipKnuckleDistance = 30.0
    
    init(thumb: FingerModel, index: FingerModel, middle: FingerModel, ring: FingerModel, little: FingerModel) {
        self.thumb = thumb
        self.index = index
        self.middle = middle
        self.ring = ring
        self.little = little
    }
    
}

class FingerModel {
    var isExtended: Bool = false
    
    convenience init() {
        self.init(isExtended: false)
    }
    
    init(isExtended: Bool) {
        self.isExtended = isExtended
    }
}
