//
//  WDC.swift
//  XBridge10
//
//  $GP
//
//  WDC - Distance to Waypoint - Great Circle
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class WDC: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
