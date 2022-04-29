//
//  R00.swift
//  XBridge10
//
//  $GP
//
//  R00 - Waypoint active route (not standard)
//
//  List of waypoint IDs in currently active route
//
//  eg1. $GPR00,EGLL,EGLM,EGTB,EGUB,EGTK,MBOT,EGTB,,,,,,,*58
//  eg2. $GPR00,MINST,CHATN,CHAT1,CHATW,CHATM,CHATE,003,004,005,006,007,,,*05
//
//  List of waypoints. This alternates with $GPWPL cycle which itself cycles waypoints.
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation

class R00: NMEA0813Base {

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
