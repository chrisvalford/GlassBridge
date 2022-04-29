//
//  ALM.swift
//  XBridge10
//
//  $GP
//  ALM - GPS Almanac Data
//
//  A set of sentences transmitted by some Garmin units in response to a received $PGRMO,GPALM,1 
//  sentence. It can also be received by some GPS units (eg. Garmin GPS 16 and GPS 17)
//  to initialize the stored almanac information in the unit.

//  Example 1: $GPALM,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,*CC

//  1 = Total number of sentences in set
//  2 = Sentence sequence number in set
//  3 = Satellite number
//  4 = GPS week number
//  5 = Bits 17 to 24 of almanac page indicating SV health
//  6 = Eccentricity
//  7 = Reference time of almanac
//  8 = Inclination angle
//  9 = Right ascension rate
//  10 = Semi major axis route
//  11 = Argument of perigee (omega)
//  12 = Ascension node longitude
//  13 = Mean anomaly
//  14 = af0 clock parameter
//  15 = af1 clock parameter
//  Example 2: $GPALM,1,1,15,1159,00,441d,4e,16be,fd5e,a10c9f,4a2da4,686e81,58cbe1,0a4,001*77

//  Field                       Example	Comments
//  Sentence ID                 $GPALM
//  Number of messages          1       Total number of messages in sequence
//  Sequence number             1       This is first message in sequence
//  Satellite PRN               15      Unique ID (PRN) of satellite message relates to
//  GPS week number             1159
//  SV health                   00      Bits 17-24 of almanac page
//  Eccentricity                441d
//  Reference time              4e      Almanac reference time
//  Inclination angle           16be
//  Rate of right ascension     fd5e
//  Roor of semi-major axis     a10c9f
//  Argument of perigee         4a2da4
//  Longitude of ascension node	686e81
//  Mean anomoly                58cbe1
//  F0 clock parameter          0a4
//  F1 clock parameter          001
//  Checksum                    *5B
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class ALM: NMEA0813Base {

    var numberOfMessages: Int?              // 1       Total number of messages in sequence
    var sequenceNumber: Int?                // 1       This is first message in sequence
    var satellitePRN: Int?                  // 15      Unique ID (PRN) of satellite message relates to
    var gpsWeekNumber: Int?                 // 1159
    var svHealth: String?                   // 00      Bits 17-24 of almanac page
    var eccentricity: String?               // 441d
    var referenceTime: String?              // 4e      Almanac reference time
    var inclinationAngle: String?           // 16be
    var rateOfRightAscension: String?       // fd5e
    var roorOfSemiMajorAxis: String?        // a10c9f
    var argumentOfPerigee: String?          // 4a2da4
    var longitudeOfAscensionNode: String?   // 686e81
    var meanAnomoly: String?                // 58cbe1
    var f0ClockParameter: String?           // 0a4
    var f1ClockParameter: String?           // 001
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }

        senderId = String(bytes: attributes[0][1...2], encoding: .utf8)!

        switch senderId {
        
        case "HC": // Compass
            print("HC is not presently supported")
        
        case "GP": // GPS
            if let string = String(bytes: attributes[5], encoding: .utf8) {
                self.numberOfMessages = Int(string)
            }
            if let string = String(bytes: attributes[5], encoding: .utf8) {
                self.sequenceNumber = Int(string)
            }
            if let string = String(bytes: attributes[5], encoding: .utf8) {
                self.satellitePRN = Int(string)
            }
            if let string = String(bytes: attributes[5], encoding: .utf8) {
                self.gpsWeekNumber = Int(string)
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                svHealth = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.eccentricity = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.referenceTime = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.inclinationAngle = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.rateOfRightAscension = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.roorOfSemiMajorAxis = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.argumentOfPerigee = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.longitudeOfAscensionNode = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.meanAnomoly = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.f0ClockParameter = string
            }
            if let string = String(bytes: attributes[1], encoding: .utf8) {
                self.f1ClockParameter = string
            }

        default:
            print("Unsupported sender")
        }
    }
}
