//
//  GGA.swift
//  XBridge10
//
//  $GP
//
//  GGA - Global Positioning System Fix Data
//
//  eg1. $GPGGA,170834,4124.8963,N,08151.6838,W,1,05,1.5,280.2,M,-34.0,M,,,*59
//
//  Name                                    Example Data	Description
//  Sentence Identifier                     $GPGGA          Global Positioning System Fix Data
//  Time                                    170834          17:08:34 UTC
//  Latitude                                4124.8963, N	41d 24.8963' N or 41d 24' 54" N
//  Longitude                               08151.6838, W	81d 51.6838' W or 81d 51' 41" W
//  Fix Quality:                            1               Data is from a GPS fix
//  - 0 = Invalid
//  - 1 = GPS fix
//  - 2 = DGPS fix
//  Number of Satellites                    05              5 Satellites are in view
//  Horizontal Dilution of Precision (HDOP)	1.5             Relative accuracy of horizontal position
//  Altitude                                280.2, M        280.2 meters above mean sea level
//  Height of geoid above WGS84 ellipsoid	-34.0, M        -34.0 meters
//  Time since last DGPS update             blank           No last update
//  DGPS reference station id               blank           No station id
//  Checksum                                *75             Used by program to check for transmission errors
//  Courtesy of Brian McClure, N8PQI.
//
//  Global Positioning System Fix Data. Time, position and fix related data for a GPS receiver.
//
//  eg2. $GPGGA,hhmmss.ss,ddmm.mmm,a,dddmm.mmm,b,q,xx,p.p,a.b,M,c.d,M,x.x,nnnn
//
//  hhmmss.ss = UTC of position
//  ddmm.mmm = latitude of position
//  a = N or S, latitutde hemisphere
//  dddmm.mmm = longitude of position
//  b = E or W, longitude hemisphere
//  q = GPS Quality indicator (0=No fix, 1=Non-differential GPS fix, 2=Differential GPS fix, 6=Estimated fix)
//  xx = number of satellites in use
//  p.p = horizontal dilution of precision
//  a.b = Antenna altitude above mean-sea-level
//  M = units of antenna altitude, meters
//  c.d = Geoidal height
//  M = units of geoidal height, meters
//  x.x = Age of Differential GPS data (seconds since last valid RTCM transmission)
//  nnnn = Differential reference station ID, 0000 to 1023
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation
import CoreLocation

class GGA: NMEA0813Base {

    var time: Int?                                          //170834          17:08:34 UTC
    var latitude: CLLocationDegrees?                          //4124.8963, N    41d 24.8963' N or 41d 24' 54" N
    var longitude: CLLocationDegrees?                         //08151.6838, W   81d 51.6838' W or 81d 51' 41" W
    var fixQuality: NSDecimalNumber?                        //1               Data is from a GPS fix - 0 = Invalid, - 1 = GPS fix, - 2 = DGPS fix
    var numberOfSatellites: Int?                            //05              5 Satellites are in view
    var horizontalDilutionOfPrecision: NSDecimalNumber?     //1.5            (HDOP) Relative accuracy of horizontal position
    var altitude: NSDecimalNumber?                          //280.2, M        280.2 meters above mean sea level
    var heightOfGeoidAboveWGS84ellipsoid: NSDecimalNumber?  //-34.0, M        -34.0 meters
    var timeSinceLastDGPSupdate: String?                    //blank           No last update
    var dgpsReferenceStationId: Int?
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.time = Int(string)
        }
        if let string = String(bytes: attributes[2], encoding: .utf8) {
            self.latitude = CLLocationDegrees(string)
        }
        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.longitude = CLLocationDegrees(string)
        }
        if let string = String(bytes: attributes[4], encoding: .utf8) {
            self.fixQuality = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[5], encoding: .utf8) {
            self.numberOfSatellites = Int(string)
        }
        if let string = String(bytes: attributes[6], encoding: .utf8) {
            self.horizontalDilutionOfPrecision = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[7], encoding: .utf8) {
            self.altitude = NSDecimalNumber(string: string)
        }
        if let string = String(bytes: attributes[8], encoding: .utf8) {
            self.heightOfGeoidAboveWGS84ellipsoid = NSDecimalNumber(string: string)
        }
        self.timeSinceLastDGPSupdate = String(bytes: attributes[9], encoding: .utf8)
        if let string = String(bytes: attributes[10], encoding: .utf8) {
            self.dgpsReferenceStationId = Int(string)
        }
    }
}
