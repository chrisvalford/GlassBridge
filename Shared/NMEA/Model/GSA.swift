//
//  GSA.swift
//  XBridge10
//
//  $GP
//
//  GSA - GPS DOP and Active Satellites
//
//  $GPGSA,A,3,,,,,,16,18,,22,24,,,3.6,2.1,2.2*3C
//  $GPGSA,A,3,19,28,14,18,27,22,31,39,,,,,1.7,1.0,1.3*34
//  $GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,1.7,1.0,1.3*35


//  1    = Mode:  M=Manual, forced to operate in 2D or 3D OR A=Automatic, 3D/2D
//  2    = Mode:  1=Fix not available OR  2=2D OR 3=3D
//  3-14 = PRN's of Satellite Vechicles (SV's) used in position fix (null for unused fields)
//  15   = Position Dilution of Precision (PDOP)
//  16   = Horizontal Dilution of Precision (HDOP)
//  17   = Vertical Dilution of Precision (VDOP)
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GSA: NMEA0813Base {

    var modeString: String?
    var modeNumber: Int?
    var prns = [Int?](repeating: nil, count: 12)
    var pdop: Double?
    var hdop: Double?
    var vdop: Double?

    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
        self.modeString = String(bytes: attributes[1], encoding: .utf8)!

        if let string = String(bytes: attributes[2], encoding: .utf8) {
            self.modeNumber = Int(string)!
        }

        for i in 0..<12 {
            if let string = String(bytes: attributes[3+i], encoding: .utf8) {
                let value = Int(string)
                if value != nil {
                    prns[i] = value
                }
            }
        }

        if let string = String(bytes: attributes[15], encoding: .utf8) {
            self.pdop = Double(string)
        }

        if let string = String(bytes: attributes[16], encoding: .utf8) {
            self.hdop = Double(string)
        }

        if let string = String(bytes: attributes[17], encoding: .utf8) {
            if string.contains("*") {
                let components = string.components(separatedBy: "*")
                self.vdop = Double(components[0])
            } else {
                self.vdop = Double(string)
            }
        }
    }
}
