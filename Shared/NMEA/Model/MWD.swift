//
//  MWD.swift
//  GlassBridge
//
//  $GP
//
//  MWD - Wind Direction
// $--MWD,x.x,T,x.x,M,x.x,N,x.x,M*hh<CR><LF>
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class MWD: NMEA0813Base {

    var angleTrue: NSDecimalNumber?
    var trueIndicator: String?
    var angleMagnetic: NSDecimalNumber?
    var magneticIndicator: String?
    var velocityKnots: NSDecimalNumber?
    var knotIndicator: String?
    var velocityMeters: NSDecimalNumber?
    var metersIndicator: String?

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.angleTrue = NSDecimalNumber(string: string)
        }

        trueIndicator = String(bytes: attributes[5], encoding: .utf8)!

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.angleMagnetic = NSDecimalNumber(string: string)
        }

        magneticIndicator = String(bytes: attributes[5], encoding: .utf8)!

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.velocityKnots = NSDecimalNumber(string: string)
        }

        knotIndicator = String(bytes: attributes[5], encoding: .utf8)!

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.velocityMeters = NSDecimalNumber(string: string)
        }

        metersIndicator = String(bytes: attributes[5], encoding: .utf8)!

    }
}
