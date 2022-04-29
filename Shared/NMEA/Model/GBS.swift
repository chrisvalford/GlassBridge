//
//  GBS.swift
//  XBridge10
//
//  $GP
//
//  GBS - GPS Satellite Fault Detection
//
//        1         2   3   4   5   6   7   8   9
//  |         |   |   |   |   |   |   |   |
//      $--GBS,hhmmss.ss,x.x,x.x,x.x,x.x,x.x,x.x,x.x*hh<CR><LF>
//  
//  Field Number:
//  1) UTC time of the GGA fix addociated with this sentence
//  2) Expected error in latitude
//  3) Expected error in longitude
//  4) Expected error in altitude
//  5) Most likely failed satellite
//  6) Probability of missed detection for most likely failed satellite
//  7) Estimate of bias on most likely failed satellite
//  8) Standard deviation on bias estimate
//  9) Checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GBS: NMEA0813Base {

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
