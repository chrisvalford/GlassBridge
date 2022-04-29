//
//  VDM.swift
//  XBridge10
//
//  $GP
//
//  VDM - AIS VHF Datalink Message. 
//  AIS NMEA sentence that contains data about another ship.
//  Information: http://gpsd.berlios.de/AIVDM.html
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class VDM: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
