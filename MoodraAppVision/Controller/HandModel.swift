//
//  HandModel.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 29/02/24.
//

import Foundation


class HandModel {
    static let leftHand = HandModel()
    static let rightHand = HandModel()
    
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
    
    convenience init() {
        self.init(thumb: FingerModel(), index: FingerModel(), middle: FingerModel(), ring: FingerModel(), little: FingerModel())
    }
    
    init(thumb: FingerModel, index: FingerModel, middle: FingerModel, ring: FingerModel, little: FingerModel) {
        self.thumb = FingerModel()
        self.index = FingerModel()
        self.middle = FingerModel()
        self.ring = FingerModel()
        self.little = FingerModel()
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
