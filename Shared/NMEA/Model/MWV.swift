//
//  MWV.swift
//  GlassBridge
//
//  $GP
//
//  MWV - Wind Speed and Angle
//
//  MWV - Wind Speed and Angle
//        1   2 3   4 5
//        |   | |   | |
//  $--MWV,x.x,a,x.x,a*hh<CR><LF>
//  Field Number:
//
//  1. Wind Angle, 0 to 359 degrees
//
//  2. Reference, R = Relative, T = True
//
//  3. Wind Speed
//
//  4. Wind Speed Units, K/M/
//
//  5. Status, A = Data Valid, V = Invalid
//
//  6. Checksum
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class MWV: NMEA0813Base {

    var windAngle: NSDecimalNumber?
    var reference: String? // R or T
    var windSpeed: NSDecimalNumber?
    var windSpeedUnit: String? // K or M
    var status: String? // A or V

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.windAngle = NSDecimalNumber(string: string)
        }

        self.reference = String(bytes: attributes[2], encoding: .utf8)!

        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.windSpeed = NSDecimalNumber(string: string)
        } 
        self.windSpeedUnit = String(bytes: attributes[2], encoding: .utf8)!
        self.status = String(bytes: attributes[2], encoding: .utf8)!
    }
}
