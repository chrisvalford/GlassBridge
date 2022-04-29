//
//  XTE.swift
//  XBridge10
//
//  $GP
//
//  XTE - Cross-Track Error, Measured
//
//  eg1. $GPXTE,A,A,0.67,L,N*6F
//
//  A            General warning flag V = warning (Loran-C Blink or SNR warning)
//  A            Not used for GPS (Loran-C cycle lock flag)
//  0.67         cross track error distance
//  L            Steer left to correct error (or R for right)
//  N            Distance units - Nautical miles
//
//  eg2. $GPXTE,A,A,4.07,L,N*6D
//              1 2 3    4 5 6
//
//  1    A         validity
//  2    A         cycle lock
//  3    4.07      distance off track
//  4    L         steer left (L/R)
//  5    N         distance units
//  6    *6D       checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class XTE: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
