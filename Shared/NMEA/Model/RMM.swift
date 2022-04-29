//
//  RMM.swift
//  XBridge10
//
//  $PG
//
//  RMM - Map datum
//
//  Example 1: $PGRMM,Astrln Geod '66*51
//
//  'Astrln Geod 66' = Name of currently active datum
//
//  Example 2: $PGRMM,NAD27 Canada*2F
//
//  'NAD27 Canada' = Name of currently active datum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class RMM: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
