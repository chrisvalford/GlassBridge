//
//  VWR.swift
//  XBridge10
//
//  $GP
//  VWR - Relative (Aparent) Wind Speed and Angle
//
//              1  2  3  4  5  6  7  8 9
//              |  |  |  |  |  |  |  | |
//      $--VWR,x.x,a,x.x,N,x.x,M,x.x,K*hh<CR><LF>
//
//  $IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52
//
//  Field Number:
//  1) Measured wind angle relative to the vessel, 0 to 180 
//  2) Wind direction Left/Right of vessel heading
//  3) Speed
//  4) N = Knots
//  5) Speed
//  6) M = Meters Per Second
//  7) Speed
//  8) K = Kilometers Per Hour
//  9) Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VWR: NMEA0813Base {
    // $IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52
    var windDirectionMagnitudeInDegrees: NSDecimalNumber?
    var windDirectionLeftRightOfBow: String?
    var speedKnots: NSDecimalNumber?
    var knotsIndicator: String?
    var speedMetersPerSecond: NSDecimalNumber?
    var metersPerSecondIndicator: String?
    var speedKmph: NSDecimalNumber?
    var kmphIndicator: String?
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.windDirectionMagnitudeInDegrees = NSDecimalNumber(string: string)
        }

        windDirectionLeftRightOfBow = String(bytes: attributes[2], encoding: .utf8)!

        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.speedKnots = NSDecimalNumber(string: string)
        }

        if var kn = String(bytes: attributes[4], encoding: .utf8) {
            if kn == "N" {
                kn = "kn"
            }
            knotsIndicator = kn 
        }

        if let string = String(bytes: attributes[5], encoding: .utf8) {
            self.speedMetersPerSecond = NSDecimalNumber(string: string)
        }

        metersPerSecondIndicator = String(bytes: attributes[6], encoding: .utf8)!

        if let string = String(bytes: attributes[7], encoding: .utf8) {
            self.speedKmph = NSDecimalNumber(string: string)
        }

        kmphIndicator = String(bytes: attributes[8], encoding: .utf8)!
    }
}
