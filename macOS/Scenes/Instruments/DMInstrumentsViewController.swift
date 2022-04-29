//
//  DMInstrumentsViewController.swift
//  XBridge10
//
//  Created by Christopher Alford on 08/01/2017.
//  Copyright © 2017 marine.digital. All rights reserved.
//

import Cocoa
import Combine

class DMInstrumentsViewController: NSViewController {

    var sentenceProcessor = SentanceProcessor.shared
    var acHeading: AnyCancellable?
    var acWind: AnyCancellable?

    @IBOutlet weak var windAngleDial: DMWindAngleDialView!
    @IBOutlet weak var headingDial: DMHeadingDialView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.black.cgColor

        acHeading = sentenceProcessor.$headingMagnetic.sink(receiveValue: { chartAngle in
            if let _ = chartAngle {
                let num = chartAngle!.magneticDegrees
                self.headingDial.currentHeading = CGFloat(truncating: num!)
                if let _ = chartAngle!.trueDegrees {
                    self.headingDial.headingText = chartAngle!.trueDegrees!.stringValue
                }
                self.headingDial.needsDisplay = true
            }
        })

        acWind = sentenceProcessor.$wind.sink(receiveValue: { windModel in
            if let _ = windModel {
                let num = windModel!.lastWindObject.angle
                self.windAngleDial.windAngle = CGFloat(num)
                self.windAngleDial.windVelocity = windModel!.lastWindObject.velocity
                self.windAngleDial.mode = windModel!.lastWindObject.velocityUnit
                self.windAngleDial.needsDisplay = true
            }
        })
    }

}
