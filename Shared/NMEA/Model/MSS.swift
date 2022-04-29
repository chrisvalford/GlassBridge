//
//  MSS.swift
//  XBridge10
//
//  $GP
//
//  MSS - Beacon Receiver Status
//
//  Example 1: $GPMSS,55,27,318.0,100,*66
//
//  where:
//  55         signal strength in dB
//  27         signal to noise ratio in dB
//  318.0      Beacon Frequency in KHz
//  100        Beacon bitrate in bps
//  *66        checksum
//  Example 2: $GPMSS,0.0,0.0,0.0,25,2*6D
//
//  Field           Example	Comments
//  Sentence ID     $GPMSS
//  Signal strength	0.0     Signal strength (dB 1uV)
//  SNR             0.0     Signal to noise ratio (dB)
//  Frequency       0.0     Beacon frequency (kHz)
//  Data rate       25      Beacon data rate (BPS)
//  Unknown field	2       Unknown field sent by GPS receiver used for test
//  Checksum        *6D
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class MSS: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
