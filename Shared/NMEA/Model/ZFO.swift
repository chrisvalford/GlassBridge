//
//  ZFO.swift
//  XBridge10
//
//  $GP
//
//  ZFO - UTC & Time from Origin Waypoint
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class ZFO: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
