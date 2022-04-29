//
//  BOD.swift
//  GlassBridge
//
//  $GP
//  BOD - Bearing, Origin to Destination
//
//  eg.  BOD,045.,T,023.,M,DEST,START
//  045.,T       bearing 045 degrees True from "START" to "DEST"
//  023.,M       breaing 023 degrees Magnetic from "START" to "DEST"
//  DEST         destination waypoint ID
//  START        origin waypoint ID
//
//  Example 1: $GPBOD,099.3,T,105.6,M,POINTB,*48
//
//  Waypoint ID: "POINTB" Bearing 99.3 True, 105.6 Magnetic
//  This sentence is transmitted in the GOTO mode, without an active route on your GPS.
//  WARNING: this is the bearing from the moment you press enter in the GOTO page to the
//  destination waypoint and is NOT updated dynamically! To update the information,
//  (current bearing to waypoint), you will have to press enter in the GOTO page again.

//  Example 2: $GPBOD,097.0,T,103.2,M,POINTB,POINTA*4A
//
//  This sentence is transmitted when a route is active. It contains the active leg
//  information: origin waypoint "POINTA" and destination waypoint "POINTB", bearing between
//  the two points 97.0 True, 103.2 Magnetic. It does NOT display the bearing from current
//  location to destination waypoint! WARNING Again this information does not change until
//  you are on the next leg of the route. (The bearing from POINTA to POINTB does not change
//  during the time you are on this leg.)
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation
import CoreLocation

class BOD: NMEA0813Base {

    var bearingAT: NSDecimalNumber?
    var bearingAM: NSDecimalNumber?
    var bearingBT: NSDecimalNumber?
    var bearingBM: NSDecimalNumber?
    var destinationWaypointId: String?
    var originWaypointId: String?

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        
        if let hdString = String(bytes: attributes[1], encoding: .utf8) {
            self.bearingAT = NSDecimalNumber(string: hdString)
        } 

        if let hdString = String(bytes: attributes[2], encoding: .utf8) {
            self.bearingAM = NSDecimalNumber(string: hdString)
        }

        if let hdString = String(bytes: attributes[3], encoding: .utf8) {
            self.bearingBT = NSDecimalNumber(string: hdString)
        }

        if let hdString = String(bytes: attributes[4], encoding: .utf8) {
            self.bearingBM = NSDecimalNumber(string: hdString)
        }

        destinationWaypointId = String(bytes: attributes[5], encoding: .utf8)!
        originWaypointId = String(bytes: attributes[6], encoding: .utf8)!
    }
}
