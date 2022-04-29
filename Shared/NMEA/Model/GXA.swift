//
//  GXA.swift
//  XBridge10
//
//  $GP
//
//  GXA - TRANSIT Position
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GXA: NMEA0813Base {
    
    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }

    }
}
