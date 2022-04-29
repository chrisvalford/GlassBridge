//
//  DBT.swift
//  XBridge10
//
//  $GP
//
//  DBT - Depth Below Transducer
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class DBT: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
