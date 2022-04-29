//
//  RME.swift
//  GlassBridge
//
//  Created by Christopher Alford on 23.05.20.
//

import Foundation

class RME: NMEA0813Base {

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
