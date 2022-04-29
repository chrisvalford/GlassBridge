//
//  HDT.swift
//  GlassBridge
//
//  $GP
//
//  HDT - Heading, True
//
//  Actual vessel heading in degrees Ture produced by any device or system producing true heading.
//
//  $--HDT,x.x,T
//  x.x = Heading, degrees True
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class HDT: NMEA0813Base {

    var headingDegrees: NSDecimalNumber?
    var magneticOrTrue: String? // Should be T

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
