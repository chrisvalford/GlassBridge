//
//  DBS.swift
//  XBridge10
//
//  $GP
//  DBS - Depth Below Surface
//
//             1   2 3   4 5   6 7
//             |   | |   | |   | |
//      $--DBS,x.x,f,x.x,M,x.x,F*hh<CR><LF>
//
//  Field Number:
//  1) Depth, feet
//  2) f = feet
//  3) Depth, meters
//  4) M = meters
//  5) Depth, Fathoms
//  6) F = Fathoms
//  7) Checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class DBS: NMEA0813Base {

    var depthFeet: NSDecimalNumber?
    var feetIndicator: String?
    var depthMeters: NSDecimalNumber?
    var meterIndicator: String?
    var depthFathoms: NSDecimalNumber?
    var fathomIndicator: String?
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
        }

        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.depthFeet = NSDecimalNumber(string: string)
        }

        self.feetIndicator = String(bytes: attributes[2], encoding: .utf8)

        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.depthMeters = NSDecimalNumber(string: string)
        }

        self.meterIndicator = String(bytes: attributes[2], encoding: .utf8)

        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.depthFathoms = NSDecimalNumber(string: string)
        }

        self.fathomIndicator = String(bytes: attributes[2], encoding: .utf8)
    }
}
