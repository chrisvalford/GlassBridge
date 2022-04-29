//
//  HBT.swift
//  XBridge10
//
//  $GP
//
//  HBT - Heartbeat Supervision Report
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class HBT: NMEA0813Base {
    
    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }

    }
}
