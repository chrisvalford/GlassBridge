//
//  MSK.swift
//  XBridge10
//
//  $GP
//
//  MSK - Control for a Beacon Receiver
//
//  $GPMSK,318.0,A,100,M,2*45
//
//  where:
//  318.0      Frequency to use
//  A          Frequency mode, A=auto, M=manual
//  100        Beacon bit rate
//  M          Bitrate, A=auto, M=manual
//  2          frequency for MSS message status (null for no status)
//  *45        checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class MSK: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
