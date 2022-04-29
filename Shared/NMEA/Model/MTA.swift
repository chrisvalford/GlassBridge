//
//  MTA.swift
//  XBridge10
//
//  $GP
//
//  MTA - Air Temperature (to be phased out)
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class MTA: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
