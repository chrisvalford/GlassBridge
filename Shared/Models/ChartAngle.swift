//
//  ChartAngle.swift
//  GlassBridge
//
//  Created by Christopher Alford on 26.05.20.
//

import Foundation

struct ChartAngle {

    var magneticDegrees: NSDecimalNumber?
    var trueDegrees: NSDecimalNumber?
    var variationDegrees: NSDecimalNumber?
    var variationDirection: String?
    var deviationDegrees: NSDecimalNumber?
    var deviationDirection: String?

    init(magneticDegrees: NSDecimalNumber?,
         variationDegrees: NSDecimalNumber?, variationDirection: String?,
         deviationDegrees: NSDecimalNumber?, deviationDirection: String?,
         calculateTrue: Bool = true) {

        self.magneticDegrees = magneticDegrees
        self.variationDegrees = variationDegrees
        self.variationDirection = variationDirection
        self.deviationDegrees = deviationDegrees
        self.deviationDirection = deviationDirection
        if calculateTrue == true {
            self.trueDegrees = magneticToTrue()
        }
    }


    mutating func magneticToTrue() -> NSDecimalNumber {

        var finalAngle = magneticDegrees!

        if let varDeg = variationDegrees, let varDir = variationDirection {
            if varDir == "E" {
                finalAngle = finalAngle.subtracting(varDeg)
            } else if varDir == "W" {
                finalAngle = finalAngle.adding(varDeg)
            }
        }
        if let devDeg = deviationDegrees, let devDir = deviationDirection {
            if devDir == "E" {
                finalAngle = finalAngle.subtracting(devDeg)
            } else if devDir == "W" {
                finalAngle = finalAngle.adding(devDeg)
            }
        }
        return finalAngle
    }
}
