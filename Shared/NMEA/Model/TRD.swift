//
//  TRD.swift
//  XBridge10
//
//  $GP
//
//  TRD - Thruster Response Data
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class TRD: NMEA0813Base {
    
    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }

    }
}
