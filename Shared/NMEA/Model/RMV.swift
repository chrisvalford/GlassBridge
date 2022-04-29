//
//  RMV.swift
//  XBridge10
//
//  $PG
//
//  RMV - 3D Velocity Information
//
//  $PGRMV,1,2,3*HH
//  1 = True east velocity, metres / sec
//  2 = True north velocity, metres / sec
//  3 = Upward velocity, metres / sec
//  HH = Checksum
//
//  Created by Christopher Alford on 09/08/2014.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMV: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
