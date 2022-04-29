//
//  GLL.swift
//  XBridge10
//
//  $GP
//
//  GLL - Geographic Position, Latitude/Longitude
//
//  eg1. $GPGLL,3751.65,S,14507.36,E*77
//  eg2. $GPGLL,4916.45,N,12311.12,W,225444,A*31
//
//  4916.46,N    Latitude 49 deg. 16.45 min. North
//  12311.12,W   Longitude 123 deg. 11.12 min. West
//  225444       Fix taken at 22:54:44 UTC
//  A            Data valid
//
//  eg3. $GPGLL,5133.81,N,00042.25,W*75
//              1       2 3        4 5

//  1    5133.81   Current latitude
//  2    N         North/South
//  3    00042.25  Current longitude
//  4    W         East/West
//  5    *75       checksum
//
//  $--GLL,lll.ll,a,yyyyy.yy,a,hhmmss.ss,A llll.ll = Latitude of position
//
//  a = N or S
//  yyyyy.yy = Longitude of position
//  a = E or W
//  hhmmss.ss = UTC of position
//  A = status: A = valid data
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation
import CoreLocation

class GLL: NMEA0813Base {

    var latitude: CLLocationDegrees = 0     // 5133.81   Current latitude
    var latitudeDirection: String   = ""    // N         North/South
    var longitude: CLLocationDegrees = 0    // 00042.25  Current longitude
    var longitudeDirection: String = ""     // W         East/West
    var time: Int = 0                       // 225444    Fix taken at 22:54:44 UTC
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.latitude = try! CLLocationDegrees(DDMMmm: string)
        }
        self.latitudeDirection = String(bytes: attributes[2], encoding: .utf8)!
        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.longitude = try! CLLocationDegrees(DDMMmm: string)
        }
        self.longitudeDirection = String(bytes: attributes[4], encoding: .utf8)!
        if let string = String(bytes: attributes[5], encoding: .utf8) {
            self.time = Int(string)!
        }
    }
}
