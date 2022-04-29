//
//  GTD.swift
//  XBridge10
//
//  $GP
//  GTD - Geographic Location in Time Differences
//
//         1   2   3   4   5  6
//  |   |   |   |   |  |
//      $--GTD,x.x,x.x,x.x,x.x,x.x*hh<CR><LF>
//
//  Field Number:
//  1) time difference
//  2) time difference
//  3) time difference
//  4) time difference
//  5) time difference
//  n) checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GTD: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
