//
//  APA.swift
//  XBridge10
//
//  $GP
//  APA - Autopilot format "A"
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class APA: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
