//
//  NRM.swift
//  XBridge10
//
//  $GP
//
//  NRM - NAVTEX Receiver Masl Command
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class NRM: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
