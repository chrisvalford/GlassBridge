//
//  DTM.swift
//  XBridge10
//
//  $GP
//
//  DTM - Datum Reference
//
//         1   2 3       4 5       6 7 8  9
//  |   | |       | |       | | |  |
//      $--DTM,xxx,x,xx.xxxx,x,xx.xxxx,x,,xxx*hh<CR><LF>
//
//  Field Number:
//  1) Local datum code
//  W84 - WGS84
//  W72 - WGS72
//  S85 - SGS85
//  P90 - PE90
//  999 - User defined
//  IHO datum code
//  2) Local datum sub code
//  3) Latitude offset (minute)
//  4) Latitude offset mark (N: +, S: -)
//  5) Longitude offset (minute)
//  6) Longitude offset mark (E: +, W: -)
//  7) Altitude offset (m) Always null
//  8) Datum
//  W84 - WGS84
//  W72 - WGS72
//  S85 - SGS85
//  P90 - PE90
//  ...
//  9) Checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class DTM: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
