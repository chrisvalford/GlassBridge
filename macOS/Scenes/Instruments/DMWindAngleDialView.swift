//
//  DMWindAngleView.swift
//  XBridge
//
//  Created by Christopher Alford on 02.04.19.
//  Copyright © 2019 marine.digital. All rights reserved.
//

import SwiftUI
import Cocoa

class DMWindAngleDialView: NSView {

    var windAngle: CGFloat = 0.0
    var windVelocity = "0.0"
    var mode = "TRUE"

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        DMWindAngleDial.drawDMWindAngleDial(frame: bounds, pointerAngle: windAngle, windVelocity: windVelocity, mode: mode)
    }
    
}

struct WindAngleView: NSViewRepresentable {

    var someVar: CGFloat = 99

    typealias NSViewType = DMWindAngleDialView

    func makeNSView(context: Context) -> DMWindAngleDialView {
        DMWindAngleDialView()
    }

    func updateNSView(_ nsView: DMWindAngleDialView, context: Context) {
        nsView.windAngle = someVar
        nsView.draw(nsView.visibleRect)
    }

    
}
