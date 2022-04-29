//
//  RMB.swift
//  GlassBridge
//
//  Created by Christopher Alford on 24.05.20.
//

import Foundation

class RMB: NMEA0813Base {

    var status: String? // A or V
    var crosstrackError: NSDecimalNumber?
    var steerToCorrect: String?
    var originWaypointId: String?
    var destinationWaypointId: String?
    var destinationWaypointLatitude: NSDecimalNumber?
    var northSouth: String?
    var destinationWaypointLongitude: NSDecimalNumber?
    var eastWast: String?
    var destinationRange: NSDecimalNumber?
    var destinationBearingTrue: NSDecimalNumber?
    var destinationVelocity: NSDecimalNumber?
    var arrivalAlarm: String?

    override init(rawData: String) throws {

        do {
            try super.init(rawData: rawData)
        }

        if senderId == "PG" {
            print("PG not yet implemented")
            return
        }

        self.status = String(bytes: attributes[1], encoding: .utf8)!
        if let string = String(bytes: attributes[2], encoding: .utf8) {
            self.crosstrackError = NSDecimalNumber(string: string)
        }
        self.steerToCorrect = String(bytes: attributes[3], encoding: .utf8)!
        originWaypointId = String(bytes: attributes[4], encoding: .utf8)!
        destinationWaypointId = String(bytes: attributes[5], encoding: .utf8)!
        if let string = String(bytes: attributes[6], encoding: .utf8) {
            self.destinationWaypointLatitude = NSDecimalNumber(string: string)
        }
        self.northSouth = String(bytes: attributes[7], encoding: .utf8)!
        if let string = String(bytes: attributes[8], encoding: .utf8) {
            self.destinationWaypointLongitude = NSDecimalNumber(string: string)
        }
        self.eastWast = String(bytes: attributes[9], encoding: .utf8)!
        if let string = String(bytes: attributes[10], encoding: .utf8) {
            self.destinationRange = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[11], encoding: .utf8) {
            self.destinationBearingTrue = NSDecimalNumber(string: string)
        } 
        if let string = String(bytes: attributes[12], encoding: .utf8) {
            self.destinationVelocity = NSDecimalNumber(string: string)
        }
        arrivalAlarm = String(bytes: attributes[13], encoding: .utf8)! // A or V
    }
}

//  $GP, $PG
//
//  RMB - Recommended Minimum Navigation Information
//          (sent by nav. receiver when a destination waypoint is active)
//
//  eg1. $GPRMB,A,0.66,L,003,004,4917.24,N,12309.57,W,001.3,052.5,000.5,V*20
//
//  A            Data status A = OK, V = warning
//  0.66,L       Cross-track error (nautical miles, 9.9 max.), steer Left to correct (or R = right)
//  003          Origin waypoint ID
//  004          Destination waypoint ID
//  4917.24,N    Destination waypoint latitude 49 deg. 17.24 min. N
//  12309.57,W   Destination waypoint longitude 123 deg. 09.57 min. W
//  001.3        Range to destination, nautical miles
//  052.5        True bearing to destination
//  000.5        Velocity towards destination, knots
//  V            Arrival alarm  A = arrived, V = not arrived
//  *0B          mandatory checksum
//
//  eg2. $GPRMB,A,4.08,L,EGLL,EGLM,5130.02,N,00046.34,W,004.6,213.9,122.9,A*3D
//              1 2    3 4    5    6       7 8        9 10    11    12    13 14
//
//  1    A         validity
//  2    4.08      off track
//  3    L         Steer Left (L/R)
//  4    EGLL      last waypoint
//  5    EGLM      next waypoint
//  6    5130.02   Latitude of Next waypoint
//  7    N         North/South
//  8    00046.34  Longitude of next waypoint
//  9    W         East/West
//  10   004.6     Range
//  11   213.9     bearing to waypt.
//  12   122.9     closing velocity
//  13   A         validity
//  14   *3D       checksum
//
//  eg3. $GPRMB,A,x.x,a,c--c,d--d,llll.ll,e,yyyyy.yy,f,g.g,h.h,i.i,j*kk
//  1    = Data Status (V=navigation receiver warning)
//  2    = Crosstrack error in nautical miles
//  3    = Direction to steer (L or R) to correct error
//  4    = Origin waypoint ID#
//  5    = Destination waypoint ID#
//  6    = Destination waypoint latitude
//  7    = N or S
//  8    = Destination waypoint longitude
//  9    = E or W
//  10   = Range to destination in nautical miles
//  11   = Bearing to destination, degrees True
//  12   = Destination closing velocity in knots
//  13   = Arrival status; (A=entered or perpendicular passed)
//  14   = Checksum
//
//  ===================================================================================================
//  $PGRMB,1,2,3,4,5,6,7,8,9*HH
//  1 = Tune frequency, Kilohertz (283.5 - 325.0 in 0.5 steps)
//  2 = Bit rate, Bits / second (0, 25, 50, 100, 200)
//  3 = SNR (Signal to Noise Ratio), 0 - 31
//  4 = Data Quality, 0 - 100
//  5 = Distance to beacon reference station
//  6 = Distance unit (K=Kilometres)
//  7 = Receiver communication status (0=Check wiring, 1=No signal, 2=Tuning, 3=Receiving, 4=Scanning)
//  8 = Fix source (R=RTCM, W=WAAS, N=Non-DPGS fix)
//  9 = DGPS Mode (A=Automatic, W=WAAS only, R=RTCM Only, N=None; DGPS disabled)
//  HH = Checksum
