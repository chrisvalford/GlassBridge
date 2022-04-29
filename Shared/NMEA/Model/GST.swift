//
//  GST.swift
//  XBridge10
//
//  $GP
//
//  GST - GPS Pseudorange Noise Statistics
//
//  Example: $GPGST,024603.00,3.2,6.6,4.7,47.3,5.8,5.6,22.0*58

//  Field                       Example     Comments
//  Sentence ID                 $GPGST
//  UTC Time                    024603.00	UTC time of associated GGA fix
//  RMS deviation               3.2         Total RMS standard deviation of ranges inputs to the navigation solution
//  Semi-major deviation        6.6         Standard deviation (meters) of semi-major axis of error ellipse
//  Semi-minor deviation        4.7         Standard deviation (meters) of semi-minor axis of error ellipse
//  Semi-major orientation      47.3        Orientation of semi-major axis of error ellipse (true north degrees)
//  Latitude error deviation	5.8         Standard deviation (meters) of latitude error
//  Longitude error deviation	5.6         Standard deviation (meters) of longitude error
//  Altitude error deviation	22.0        Standard deviation (meters) of latitude error
//  Checksum                    *58
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GST: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
