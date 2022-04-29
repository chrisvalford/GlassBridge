//
//  DMHeadingDialView.swift
//  XBridge10
//
//  Created by Christopher Alford on 20/01/2017.
//  Copyright © 2017 marine.digital. All rights reserved.
//

import Foundation
import Cocoa

class DMHeadingDialView: NSView {
    
    var currentHeading: CGFloat = 0.0
    var headingText = "0.0"
    var headingMode = "TRUE"

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let textRotation = currentHeading * -1

        DMHeadingDial.drawDMHeadingCompass(frame: bounds, resizing: DMHeadingDial.ResizingBehavior.aspectFit, cardRotation: currentHeading, textRotation: textRotation, heading: headingText, mode: headingMode)
    }
    
}
