//
//  RMIE.swift
//  XBridge10
//
//  $PG
//
//  RMIE - Sensor Initialization Information Enquiry
//
//  The unit will respond by transmitting a $PGRMI sentence containing the current default values.
//
//  $PGRMIE*HH
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMIE: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
