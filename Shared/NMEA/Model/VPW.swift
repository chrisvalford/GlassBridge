//
//  VPW.swift
//  XBridge10
//
//  $GP
//
//  VPW - Speed, Measured Parallel to Wind
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VPW: NMEA0813Base {
    
    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }

    }
}
