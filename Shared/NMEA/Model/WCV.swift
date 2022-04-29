//
//  WCV.swift
//  XBridge10
//
//  $GP
//
//  WCV - Waypoint Closure Velocity
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class WCV: NMEA0813Base {

    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
