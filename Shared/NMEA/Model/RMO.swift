//
//  RMO.swift
//  XBridge10
//
//  $PG
//
//  RMO - Output Sentence Enable / Disable
//
//  $PGRMO,xxxxx,n*HH
//  xxxxx = Target sentence name (eg. GPGGA, GPGSA)
//  n = Target mode (   0 = Disable specified sentence,
//                      1 = Enable specified sentence,
//                      2 = Disable all output sentences except PSLIB,
//                      3 = Enable all output sentences except GPALM,
//                      4 = Restore factory defaults)
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMO: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
