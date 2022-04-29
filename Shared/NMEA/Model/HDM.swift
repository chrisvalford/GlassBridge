//
//  HDM.swift
//  GlassBridge
//
//  $GP
//
//  HDM - Heading - Magnetic
//
//             1   2 3
//             |   | |
//      $--HDM,x.x,M*hh<CR><LF>
//
//  Field Number:
//  1) Heading Degrees, magnetic
//  2) M = magnetic
//  3) Checksum
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class HDM: NMEA0813Base {

    var headingDegrees: NSDecimalNumber?
    var magneticOrTrue: String? // Should be M

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.headingDegrees = NSDecimalNumber(string: string)
        } 

        self.magneticOrTrue = String(bytes: attributes[2], encoding: .utf8)!
    }
}
