//
//  RMI.swift
//  XBridge10
//
//  $PG
//
//  RMI - Sensor Initialization Information
//
//  Used to set the GPS sensor's set time and position and then commences satellite 
//  acquisition. The GPS will also transmit this sentence upon receiving this same
//  sentence or the $PGRMIE sentence.
//
//  $PGRMI,1,2,3,4,5,6,7*HH
//  1 = Latitude, dddmm.mmm format
//  2 = Latitude hemisphere, N or S
//  3 = Longitude, dddmm.mmm format
//  4 = Longitude hemisphere, N or S
//  5 = Current UTC date, ddmmyy format
//  6 = Current UTC time, hhmmss format
//  7 = Receiver command (A=Auto locate, R=Unit reset)
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMI: NMEA0813Base {

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
