//
//  GSV.swift
//  XBridge10
//
//  $GP
//
//  GSV - GPS Satellites in View
//
//  eg. $GPGSV,3,1,11,03,03,111,00,04,15,270,00,06,01,010,00,13,06,292,00*74
//      $GPGSV,3,2,11,14,25,170,00,16,57,208,39,18,67,296,40,19,40,246,00*74
//      $GPGSV,3,3,11,22,42,067,42,24,14,311,43,27,05,244,00,,,,*4D
//
//  $GPGSV,1,1,13,02,02,213,,03,-3,000,,11,00,121,,14,13,172,05*62
//
//  1    = Total number of messages of this type in this cycle
//  2    = Message number
//  3    = Total number of SVs in view
//  4    = SV PRN number
//  5    = Elevation in degrees, 90 maximum
//  6    = Azimuth, degrees from true north, 000 to 359
//  7    = SNR, 00-99 dB (null when not tracking)
//  8-11 = Information about second SV, same as field 4-7
//  12-15= Information about third SV, same as field 4-7
//  16-19= Information about fourth SV, same as field 4-7
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GSV: NMEA0813Base {

    struct SatelliteInView {
        let prn: Int
        let elevation: Double?  // 90º max
        let azimuth: Double?    // Degrees from true north, 000 to 359
        let snr: Int?           // 00-99 dB, null when not tracking
    }

    //$GPGSV,2,1,08,[01,40,083,46],[02,17,308,41],[12,07,344,39],[14,22,228,45]
    var totalMessages: Int?
    var messageNumber: Int?
    var numberOfSatellitesInView: Int?
    var satallites = [SatelliteInView]() // Maximum of 4

    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}

/*
 GSV - Satellites in View shows data about the satellites that the unit might be able to find based on its viewing mask and almanac data. It also shows current ability to track this data. Note that one GSV sentence only can provide data for up to 4 satellites and thus there may need to be 3 sentences for the full information. It is reasonable for the GSV sentence to contain more satellites than GGA might indicate since GSV may include satellites that are not used as part of the solution. It is not a requirment that the GSV sentences all appear in sequence. To avoid overloading the data bandwidth some receivers may place the various sentences in totally different samples since each sentence identifies which one it is.

 The field called SNR (Signal to Noise Ratio) in the NMEA standard is often referred to as signal strength. SNR is an indirect but more useful value that raw signal strength. It can range from 0 to 99 and has units of dB according to the NMEA standard, but the various manufacturers send different ranges of numbers with different starting numbers so the values themselves cannot necessarily be used to evaluate different units. The range of working values in a given gps will usually show a difference of about 25 to 35 between the lowest and highest values, however 0 is a special case and may be shown on satellites that are in view but not being tracked.

   $GPGSV,2,1,08,01,40,083,46,02,17,308,41,12,07,344,39,14,22,228,45*75

 Where:
       GSV          Satellites in view
       2            Number of sentences for full data
       1            sentence 1 of 2
       08           Number of satellites in view

       01           Satellite PRN number
       40           Elevation, degrees
       083          Azimuth, degrees
       46           SNR - higher is better
            for up to 4 satellites per sentence
       *75          the checksum data, always begins with *
 */


//self.modeString = String(bytes: attributes[1], encoding: .utf8)!
//
//if let string = String(bytes: attributes[2], encoding: .utf8) {
//    self.modeNumber = Int(string)!
//}
//
//for i in 0..<12 {
//    if let string = String(bytes: attributes[3+i], encoding: .utf8) {
//        let value = Int(string)
//        if value != nil {
//            prns[i] = value
//        }
//    }
//}
