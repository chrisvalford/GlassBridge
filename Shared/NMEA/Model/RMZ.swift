//
//  RMZ.swift
//  GlassBridge
//
//Altitude Information
//
//  eg1. $PGRMZ,246,f,3*1B
//  eg2. $PGRMZ,93,f,3*21
//
//      93,f         Altitude in feet
//       3            Position fix dimensions 2 = user altitude
//                                            3 = GPS altitude
//  This sentence shows in feet, regardless of units shown on the display.
//
//
//  eg3.  $PGRMZ,201,f,3*18
//              1  2 3
//
//      1  201   Altitude
//      2  F     Units - f-Feet
//      3  checksum
//
//  Created by Christopher Alford on 23.05.20.
//

import Foundation

class RMZ: NMEA0813Base {

    var altitude: NSDecimalNumber?
    var altitudeUnit: String?
    var positionFixDimention: Int?

    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
        
        if attributes.count < 4 {
            if let altitudeString = String(bytes: attributes[1], encoding: .utf8) {
                self.altitude = NSDecimalNumber(string: altitudeString)
            } 

            self.altitudeUnit = String(bytes: attributes[2], encoding: .utf8)!

            if let fixString = String(bytes: attributes[3], encoding: .utf8) {
                self.positionFixDimention = Int(fixString)!
            }

        } else {
            self.altitude = 0
            self.altitudeUnit = "f"
            self.positionFixDimention = 0
        }
    }
}
