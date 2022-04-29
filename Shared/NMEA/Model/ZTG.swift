//
//  ZTG.swift
//  XBridge10
//
//  $GP
//
//  ZTG - UTC & Time to Destination Waypoint
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class ZTG: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
