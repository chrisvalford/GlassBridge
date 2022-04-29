//
//  VBW.swift
//  XBridge10
//
//  $GP
//
//  VBW - Dual Ground/Water Speed
//
//  Water referenced and ground referenced speed data.
//
//  $--VBW,x.x,x.x,A,x.x,x.x,A
//  x.x = Longitudinal water speed, knots
//  x.x = Transverse water speed, knots
//  A = Status: Water speed, A = Data valid
//  x.x = Longitudinal ground speed, knots
//  x.x = Transverse ground speed, knots
//  A = Status: Ground speed, A = Data valid
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class VBW: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
