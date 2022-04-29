//
//  RMA.swift
//  GlassBridge
//
//  $GP
//
//  RMA - Recommended Minimum Specific Loran-C Data
//
//  eg. $GPRMA,A,lll,N,lll,W,x,y,ss.s,ccc,vv.v,W*hh
//  A    = Data status
//  lll  = Latitude
//  N    = N/S
//  lll  = longitude
//  S    = W/E
//  x    = not used
//  y    = not used
//  ss.s = Speed over ground in knots
//  ccc  = Course over ground
//  vv.v = Variation
//  W    = Direction of variation E/W
//  hh   = Checksum
//
//  Created by Christopher Alford on 25.05.20.
//

import Foundation
import CoreLocation

class RMA: NMEA0813Base {

    var status: String? // A or V
    var latitude: CLLocationDegrees?
    var northSouth: String?
    var longitude: CLLocationDegrees?
    var eastWast: String?
    var speedOverGround: NSDecimalNumber?
    var courseOverGround: NSDecimalNumber?
    var variation: NSDecimalNumber?
    var variationDirection: String? // E or W

    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        if senderId == "PG" {
            print("PG not yet implemented")
            return
        }

        // Attributes
        self.status = String(bytes: attributes[1], encoding: .utf8)!
        if let string = String(bytes: attributes[2], encoding: .utf8) {
            self.latitude = CLLocationDegrees(string)
        }
        self.northSouth = String(bytes: attributes[3], encoding: .utf8)!
        if let string = String(bytes: attributes[4], encoding: .utf8) {
            self.longitude = CLLocationDegrees(string)
        } 
        eastWast = String(bytes: attributes[5], encoding: .utf8)!
        // [6], and [7] are not used
        if let string = String(bytes: attributes[8], encoding: .utf8) {
            self.speedOverGround = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[9], encoding: .utf8) {
            self.courseOverGround = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[10], encoding: .utf8) {
            self.variation = NSDecimalNumber(string: string)
        }
        variationDirection = String(bytes: attributes[11], encoding: .utf8)!
    }
}
