//
//  RTE.swift
//  XBridge10
//
//  $GP
//
//  RTE - Routes
//
//  eg. $GPRTE,2,1,c,0,PBRCPK,PBRTO,PTELGR,PPLAND,PYAMBU,PPFAIR,PWARRN,PMORTL,PLISMR*73
//      $GPRTE,2,2,c,0,PCRESY,GRYRIE,GCORIO,GWERR,GWESTG,7FED*34
//             1 2 3 4 5 ..
//  1 Number of sentences in sequence
//  2 Sentence number
//  3 'c' = Current active route, 'w' = waypoint list starts with destination waypoint
//  4 Name or number of the active route
//  5... onwards, Names of waypoints in Route
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RTE: NMEA0813Base {

    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
