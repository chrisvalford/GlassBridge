//
//  WNC.swift
//  XBridge10
//
//  $GP
//
//  WNC - Distance, Waypoint to Waypoint
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class WNC: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
