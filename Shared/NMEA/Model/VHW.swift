//
//  VHW.swift
//  XBridge10
//
//  $GP
//
//  VHW - Water Speed and Heading
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VHW: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
