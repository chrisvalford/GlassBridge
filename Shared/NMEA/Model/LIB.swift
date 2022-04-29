//
//  LIB.swift
//  XBridge10
//
//  $GP
//
//  LIB - Tune DPGS Beacon Receiver
//
//  Proprietary Differential Control sentences to control a Starlink differential beacon receiver, 
//  assuming Garmin's DBR is made by Starlink.
//
//  eg1.    $PSLIB,290.5,100,J*33
//  eg2.    $PSLIB,300.0,200,K*3C
//  These two sentences are normally sent together in each group of sentences from the GPS.
//
//  The three fields are: Frequency, bit Rate, Request Type. 
//  The value in the third field may be: J = status request, K = configuration request, blank = tuning message.

//  When the GPS receiver is set to change the DBR frequency or baud rate, 
//  the "J" sentence is replaced (just once) by (for example): $PSLIB,320.0,200*59 to set the DBR to 320 KHz, 200 baud.
//
//  To tune a Garmin GBR 21, GBR 23 or equivalent beacon receiver.
//
//  $PSLIB,1,2*HH
//  1 = Beacon tune frequency, Kilohertz (283.5 - 325.0 in 0.5 steps)
//  2 = Beacon bit rate, Bits / second (0, 25, 50, 100, 200
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class LIB: NMEA0813Base {

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
