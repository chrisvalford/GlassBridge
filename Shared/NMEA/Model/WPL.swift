//
//  WPL.swift
//  XBridge10
//
//  $GP
//
//  WPL - Waypoint Location
//
//  eg1. $GPWPL,4917.16,N,12310.64,W,003*65
//
//  4917.16,N    Latitude of waypoint
//  12310.64,W   Longitude of waypoint
//  003          Waypoint ID
//
//  When a route is active, this sentence is sent once for each waypoint in 
//  the route, in sequence. When all waypoints have been reported, GPR00 
//  is sent in the next data set. In any group of sentences, only one WPL 
//  sentence, or an R00 sentence, will be sent.
//

//  eg2.  $GPWPL,5128.62,N,00027.58,W,EGLL*59
//               1       2 3        4 5    6
//
//  1    5128.62   Latitude of nth waypoint on list
//  2    N         North/South
//  3    00027.58  Longitude of nth waypoint
//  4    W         East/West
//  5    EGLL      Ident of nth waypoint
//  6    *59       checksum
//
/*

NOTES:

Add this when appropriate

Arrival Range:
This menu item allows setting of the range within which the HX890 determines to be the destination.
Available values are: “0.05 nm”, “0.1 nm”, “0.2 nm”, “0.5 nm”. and “1 nm”.
The default setting is “0.1 nm”.

WPL - Waypoint Location data provides essential waypoint data. It is output when navigating to indicate data about the destination and is sometimes supported on input to redefine a waypoint location. Note that waypoint data as defined in the standard does not define altitude, comments, or icon data. When a route is active, this sentence is sent once for each waypoint in the route, in sequence. When all waypoints have been reported, the RTE sentence is sent in the next data set. In any group of sentences, only one WPL sentence, or an RTE sentence, will be sent.

$GPWPL,4807.038,N,01131.000,E,WPTNME*5C

With an interpretation of:

     WPL         Waypoint Location
     4807.038,N  Latitude
     01131.000,E Longitude
     WPTNME      Waypoint Name
     *5C         The checksum data, always begins with *
*/

//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

class WPL: NMEA0813Base {

    var name: String?
    var latitudeDirection: String?
    var latitude: CLLocationDegrees?
    var longitudeDirection: String?
    var longitude: CLLocationDegrees?
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        if let string = String(bytes: attributes[1], encoding: .utf8) {
            self.latitude = CLLocationDegrees(string)
        } 
        self.latitudeDirection = String(bytes: attributes[2], encoding: .utf8)
        if let string = String(bytes: attributes[3], encoding: .utf8) {
            self.longitude = CLLocationDegrees(string)
        }
        self.longitudeDirection = String(bytes: attributes[4], encoding: .utf8)
        self.name = String(bytes: attributes[5], encoding: .utf8)
    }

    func toNMEA0183() -> String? {
        var string: String = "$GPWPL,"

        // Unreliable as some senders do not pad the strings
        // Lat and Lng values need to be paded with zeros to make the first part 5 characters

        if var latString = latitude?.description, let latDir = latitudeDirection {
            latString = pad(string: latString)
            string += "\(latString),\(latDir),"
        } else {
            return nil
        }

        if var lngString = longitude?.description, let lngDir = longitudeDirection {
            lngString = pad(string: lngString)
            string += "\(lngString),\(lngDir),"
        } else {
            return nil
        }

        if let wptName = name {
            string += "\(wptName)*"
        }
        else {
            return nil
        }

        // Get the checksum
        let checksumNumber = calculateChecksum(from: string)
        string += String(format:"%02X", checksumNumber)
        return string
    }
}
