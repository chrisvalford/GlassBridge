//
//  VDR.swift
//  XBridge10
//
//  $GP
//
//  VDR - Set and Drift
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VDR: NMEA0813Base {

    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }
      
    }
}
