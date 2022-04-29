//
//  RMF.swift
//  XBridge10
//
//  $PG
//
//  RMF - GPS Position Fix Data
//
//  $PGRMF,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15*HH
//  1 = GPS week number
//  2 = GPS seconds in current week
//  3 = UTC date, ddmmyy format
//  4 = UTC time, hhmmss format
//  5 = GPS leap second count
//  6 = Latitude, dddmm.mmmm format
//  7 = Latitude hemisphere, N or S
//  8 = Longitude, dddmm.mmmm format
//  9 = Longitude hemisphere, E or W
//  10 = Mode (M=Manual, A=Automatic)
//  11 = Fix type (0=No fix, 1=2D fix, 2=3D fix)
//  12 = Speed over ground, kilometres / hour
//  13 = Course over ground, degrees true
//  14 = PDOP (Position dilution of precision), rounded to nearest integer
//  15 = TDOP (Time dilution of precision), rounded to nearest integer
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class RMF: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
