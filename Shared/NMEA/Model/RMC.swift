//
//  RMC.swift
//  GlassBridge
//
//  $GP, $PG
//
//  RMC - Recommended Minimum Specific GPS/TRANSIT Data
//      - Sensor Configuration Information ($PG)
//
//  eg1. $GPRMC,081836,A,3751.65,S,14507.36,E,000.0,360.0,130998,011.3,E*62
//  eg2. $GPRMC,225446,A,4916.45,N,12311.12,W,000.5,054.7,191194,020.3,E*68
//
//  225446       Time of fix 22:54:46 UTC
//  A            Navigation receiver warning A = Valid position, V = Warning
//  4916.45,N    Latitude 49 deg. 16.45 min. North
//  12311.12,W   Longitude 123 deg. 11.12 min. West
//  000.5        Speed over ground, Knots
//  054.7        Course Made Good, degrees true
//  191194       UTC Date of fix, 19 November 1994
//  020.3,E      Magnetic variation, 20.3 deg. East
//  *68          mandatory checksum
//
//  eg3. $GPRMC,220516,A,5133.82,N,00042.24,W,173.8,231.8,130694,004.2,W*70
//              1      2 3       4 5        6 7     8     9      10    11 12
//
//  1   220516     Time Stamp
//  2   A          validity - A-ok, V-invalid
//  3   5133.82    current Latitude
//  4   N          North/South
//  5   00042.24   current Longitude
//  6   W          East/West
//  7   173.8      Speed in knots
//  8   231.8      True course
//  9   130694     Date Stamp
//  10  004.2      Variation
//  11  W          East/West
//  12  *70        checksum
//
//  eg4. for NMEA 0183 version 3.00 active the Mode indicator field is added
//
//  $GPRMC,hhmmss.ss,A,llll.ll,a,yyyyy.yy,a,x.x,x.x,ddmmyy,x.x,a,m*hh
//  Field #
//  1    = UTC time of fix
//  2    = Data status (A=Valid position, V=navigation receiver warning)
//  3    = Latitude of fix
//  4    = N or S of longitude
//  5    = Longitude of fix
//  6    = E or W of longitude
//  7    = Speed over ground in knots
//  8    = Track made good in degrees True
//  9    = UTC date of fix
//  10   = Magnetic variation degrees (Easterly var. subtracts from true course)
//  11   = E or W of magnetic variation
//  12   = Mode indicator, (A=Autonomous, D=Differential, E=Estimated, N=Data not valid)
//  13   = Checksum
//
//  Used to configure the GPS sensor's operation. The GPS will also transmit this sentence
//  upon receiving this same sentence or the $PGRMCE sentence.

//  $PGRMC,1,2,3,4,5,6,7,8,9,10,11,12,13,14*HH
//  1 = Fix mode (A=Automatic, 2=2D exclusively; host system must supply altitude, 3=3D exclusively)
//  2 = Altitude above/below mean sea level, metres
//  3 = Earth datum index. If the user datum index is specified (96), fields 4 to 8 must contain valid values, otherwise they must be blank.
//  4 = Semi-major axis, metres, 0.001 metre resolution
//  5 = Inverse flattening factor, 285 to 310, 10e-9 resolution
//  6 = Delta X earth centred coordinate, metres, -5000 to 5000, 1 metre resolution
//  7 = Delta Y earth centred coordinate, metres, -5000 to 5000, 1 metre resolution
//  8 = Delta Z earth centred coordinate, metres, -5000 to 5000, 1 metre resolution
//  9 = Differential mode (A=Automatic; output DGPS fixes when available otherwise non-DGPS, D=Only output differential fixes)
//  10 = NMEA 0183 baud rate (1=1200, 2=2400, 3=4800, 4=9600, 5=19200, 6=300, 7=600)
//  11 = Velocity filter (0=None, 1=Automatic, 2-255=Filter time constant; seconds)
//  12 = PPS mode (1=None, 2=1 Hertz)
//  13 = PPS pulse length, N = 0 to 48. Length (milliseconds) = (N+1)*20
//  14 = Dead reckoning valid time, 1 to 30, seconds
//  HH = Checksum
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Alford Marine. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

final class RMC: NMEA0813Base {

    @Published var utcDateTime: Date?
    @Published var dataStatus: String = "" // A or V
    @Published var latitiue: CLLocationDegrees = 0

    @Published var latitudeDirection: String = "" // N or S
    @Published var longitude: CLLocationDegrees = 0
    @Published var longitudeDirection: String = "" // E or W
    @Published var sogKn: NSDecimalNumber = 0
    @Published var tmgTrue: NSDecimalNumber = 0
    @Published var variation: NSDecimalNumber = 0 // (Easterly var. subtracts from true course)
    @Published var variationDirection: String = "" // E or W
    @Published var modeIndicator: String = "" // OPTIONAL, (A=Autonomous, D=Differential, E=Estimated, N=Data not valid)

    override init(rawData: String)  throws {

       do {
           try super.init(rawData: rawData)
       }

        senderId = String(bytes: attributes[0][1...2], encoding: .utf8)!

        switch senderId {
        case "PG":
            print("PGRMC is currently not supported")

        case "GP":
            // Build the dateTime
            if let utcTimeOfFix = String(bytes: attributes[1], encoding: .utf8), let utcDateOfFix = String(bytes: attributes[9], encoding: .utf8) {

                let hh = String(utcTimeOfFix[0...1])
                let mm = String(utcTimeOfFix[2...3])
                let ss = String(utcTimeOfFix[4...5])

                let DD = String(utcDateOfFix[0...1])
                let MM = String(utcDateOfFix[2...3])
                var YY = String(utcDateOfFix[4...5])
                if let year = Int(YY) {
                    if year > 70 && year <= 99 {
                        YY = "19" + YY
                    } else {
                        YY = "20" + YY
                    }
                }
                var components = DateComponents()
                components.year = Int(YY)
                components.month = Int(MM)
                components.day = Int(DD)
                components.hour = Int(hh)
                components.minute = Int(mm)
                components.second = Int(ss)
                var cal = Calendar.current
                cal.timeZone = TimeZone(abbreviation: "UTC")!
                let dateStamp = cal.date(from: components)!
                utcDateTime = dateStamp
            }
            if let dataStatusString = String(bytes: attributes[2], encoding: .utf8) {
                dataStatus = dataStatusString
            }
            //TODO: add the do{} catch {}
            if let string = String(bytes: attributes[3], encoding: .utf8) {
                //DDmm.mm
                self.latitiue = try CLLocationDegrees(DDMMmm: string)
            }
            self.latitudeDirection = String(bytes: attributes[4], encoding: .utf8)!
            if let string = String(bytes: attributes[5], encoding: .utf8) {
                self.longitude = try CLLocationDegrees(DDMMmm: string)
            }
            self.longitudeDirection = String(bytes: attributes[6], encoding: .utf8)!
            if let string = String(bytes: attributes[7], encoding: .utf8) {
                self.sogKn = NSDecimalNumber(string: string)
            }
            if let string = String(bytes: attributes[8], encoding: .utf8) {
                self.tmgTrue = NSDecimalNumber(string: string)
            }

            if let string = String(bytes: attributes[10], encoding: .utf8) {
                self.variation = NSDecimalNumber(string: string)
            }
            self.variationDirection = String(bytes: attributes[11], encoding: .utf8)!
            if attributes.count > 11 {
                self.modeIndicator = String(bytes: attributes[12], encoding: .utf8)!
            }

        default:
            print("Unsupported sender")
        }
    }
}
