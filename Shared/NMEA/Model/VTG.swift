//
//  VTG.swift
//  XBridge10
//
//  $GP
//
//  VTG - Track Made Good and Ground Speed
//
//  eg1. $GPVTG,360.0,T,348.7,M,000.0,N,000.0,K*34
//
//  eg2. $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K*48
//
//  054.7,T      True course made good over ground, degrees
//  034.4,M      Magnetic course made good over ground, degrees
//  005.5,N      Ground speed, N=Knots
//  010.2,K      Ground speed, K=Kilometers per hour
//
//  eg3. for NMEA 0183 version 3.00 active the Mode indicator field is added at the end
//
//  $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K,A*25
//  A            Mode indicator (A=Autonomous, D=Differential, E=Estimated, N=Data not valid)
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VTG: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
