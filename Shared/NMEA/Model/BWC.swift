//
//  BWC.swift
//  XBridge10
//
//  $GP
//  BWC - Bearing & Distance to Waypoint, Great Circle
//
//  eg1. $GPBWC,081837,,,,,,T,,M,,N,*13

//  BWC,225444,4917.24,N,12309.57,W,051.9,T,031.6,M,001.3,N,004*29
//  225444       UTC time of fix 22:54:44
//  4917.24,N    Latitude of waypoint
//  12309.57,W   Longitude of waypoint
//  051.9,T      Bearing to waypoint, degrees true
//  031.6,M      Bearing to waypoint, degrees magnetic
//  001.3,N      Distance to waypoint, Nautical miles
//  004          Waypoint ID
//
//  eg2. $GPBWC,220516,5130.02,N,00046.34,W,213.8,T,218.0,M,0004.6,N,EGLM*21
//              1      2       3 4        5 6     7 8     9 10     11 12  13
//
//  1    220516    timestamp
//  2    5130.02   Latitude of next waypoint
//  3    N         North/South
//  4    00046.34  Longitude of next waypoint
//  5    W         East/West
//  6    213.0     True track to waypoint
//  7    T         True Track
//  8    218.0     Magnetic track to waypoint
//  9    M         Magnetic
//  10   0004.6    range to waypoint
//  11   N         unit of range to waypoint, N = Nautical miles
//  12   EGLM      Waypoint name
//  13   *21       checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class BWC: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
