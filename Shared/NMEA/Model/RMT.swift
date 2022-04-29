//
//  RMT.swift
//  XBridge10
//
//  $GP, $PG
//
//  RMT - Sensor Status Information
//
//  $PGRMT,1,2,3,4,5,6,7,8,9*HH
//  1 = Garmin product model and software version (eg. GPS 16 VER 2.10)
//  2 = ROM checksum test (P=Pass, F=Fail)
//  3 = Receiver failure discrete (P=Pass, F=Fail)
//  4 = Stored data lost (R=Retained, L=Lost)
//  5 = Real time clock lost (R=Retained, L=Lost)
//  6 = Oscillator drift discrete (P=Pass, F=Excessive drift detected)
//  7 = Data collection discrtete (C=Collecting, Null=Not Collecting)
//  8 = GPS sensor temperature (Degrees C)
//  9 = GPS sensor configuration data (R=Retained, L=Lost)
//  HH = Checksum
//
//  Created by Christopher Alford on 09/08/2014.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMT: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
