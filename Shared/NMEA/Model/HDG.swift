//
//  HDG.swift
//  GlassBridge
//
//  $GP, $HC
//
//  HDG - Heading, Deviation & Variation
//
//  This sentence is used on Garmin eTrex summit, Vista and GPS76S receivers to output the value
//  of the internal flux-gate compass. Only the magnetic heading and magnetic variation is shown in the message.
//
//  $HCHDG,101.1,,,7.1,W*3C
//  $IIHDG,275.9,0.0,E,5.8,W*5F
//
//  where:
//  HCHDG    Magnetic heading, deviation, variation
//  101.1    heading
//  ,,       deviation (no data)
//  7.1,W    variation
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class HDG: NMEA0813Base {

    var headingDegrees: NSDecimalNumber = 0
    var deviationDegrees: NSDecimalNumber = 0
    var deviationDirection: String = "E" // E or W
    var variationDegrees: NSDecimalNumber = 0
    var variationDirection: String = "N" // E or W

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.headingDegrees = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[2], encoding: .utf8) {
            self.deviationDegrees = NSDecimalNumber(string: string)
        } else {
            self.deviationDegrees = 0
        }
        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.deviationDirection = string
        } else {
            self.deviationDirection = ""
        }
        if let string = String(bytes: attributes[4], encoding: .utf8) {
            self.variationDegrees = NSDecimalNumber(string: string)
        } else {
            self.variationDegrees = 0
        }
        if let hdString = String(bytes: attributes[5], encoding: .utf8) {
            // Remove the checksum
            let components = hdString.components(separatedBy: "*")
            self.variationDirection = components[0]
        } else {
            self.variationDirection = ""
        }
    }
}
