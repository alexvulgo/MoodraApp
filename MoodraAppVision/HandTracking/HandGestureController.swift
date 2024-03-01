//
//  HandGestureController.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 01/03/24.
//

import Foundation

class HandGestureController {
    var leftHand = HandModel.leftHand
    var rightHand = HandModel.rightHand
    
    func checkPataka() -> Bool {
        if !rightHand.thumb.isExtended && rightHand.index.isExtended && rightHand.middle.isExtended && rightHand.ring.isExtended && rightHand.little.isExtended {
            if  !leftHand.thumb.isExtended && leftHand.index.isExtended && leftHand.middle.isExtended && leftHand.ring.isExtended && leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
    func checkTriPataka() -> Bool {
        if !rightHand.thumb.isExtended && rightHand.index.isExtended && rightHand.middle.isExtended && !rightHand.ring.isExtended && rightHand.little.isExtended {
            if  !leftHand.thumb.isExtended && leftHand.index.isExtended && leftHand.middle.isExtended && !leftHand.ring.isExtended && leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
    func checkMushthu() -> Bool {
        if !rightHand.thumb.isExtended && !rightHand.index.isExtended && !rightHand.middle.isExtended && !rightHand.ring.isExtended && !rightHand.little.isExtended {
            if  !leftHand.thumb.isExtended && !leftHand.index.isExtended && !leftHand.middle.isExtended && !leftHand.ring.isExtended && leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
    func checkArdmachandra() -> Bool {
        if rightHand.thumb.isExtended && rightHand.index.isExtended && rightHand.middle.isExtended && rightHand.ring.isExtended && rightHand.little.isExtended {
            if  leftHand.thumb.isExtended && leftHand.index.isExtended && leftHand.middle.isExtended && leftHand.ring.isExtended && leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
    func checkChandrakala() -> Bool {
        if rightHand.thumb.isExtended && rightHand.index.isExtended && !rightHand.middle.isExtended && !rightHand.ring.isExtended && !rightHand.little.isExtended {
            if  leftHand.thumb.isExtended && leftHand.index.isExtended && !leftHand.middle.isExtended && !leftHand.ring.isExtended && !leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
    func checkShikhara() -> Bool {
        if rightHand.thumb.isExtended && !rightHand.index.isExtended && !rightHand.middle.isExtended && !rightHand.ring.isExtended && !rightHand.little.isExtended {
            if  leftHand.thumb.isExtended && !leftHand.index.isExtended && !leftHand.middle.isExtended && !leftHand.ring.isExtended && !leftHand.little.isExtended {
                return true
            }
        }
        return false
    }
    
}
