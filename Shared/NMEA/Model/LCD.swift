//
//  LCD.swift
//  XBridge10
//
//  $GP
//
//  LCD - Loran-C Signal Data
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class LCD: NMEA0813Base {
    
    override init(rawData: String) throws {

    do {
        try super.init(rawData: rawData)
    }

    }
}
