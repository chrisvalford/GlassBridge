//
//  STN.swift
//  XBridge10
//
//  $GP
//
//  STN - Multiple Data ID
//
//  This sentence is transmitted before each individual sentence where there is a need 
//  for the Listener to determine the exact source of data in the system. Examples might 
//  include dual-frequency depthsounding equipment or equipment that integrates data from 
//  a number of sources and produces a single output.
//
//  $--STN,xx
//  xx = Talker ID number, 00 to 99
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class STN: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
