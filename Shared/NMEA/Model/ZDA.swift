//
//  ZDA.swift
//  XBridge10
//
//  $GP
//
//  ZDA - UTC Date / Time and Local Time Zone Offset
//
//  Example 1: $GPZDA,hhmmss.ss,xx,xx,xxxx,xx,xx
//
//  hhmmss.ss = UTC
//  xx = Day, 01 to 31
//  xx = Month, 01 to 12
//  xxxx = Year
//  xx = Local zone description, 00 to +/- 13 hours
//  xx = Local zone minutes description (same sign as hours)
//
//  Example 2: $GPZDA,024611.08,25,03,2002,00,00*6A
//
//  Field               Example     Comments
//  Sentence ID         $GPZDA
//  UTC Time            024611.08	UTC time
//  UTC Day             25          UTC day (01 to 31)
//  UTC Month           03          UTC month (01 to 12)
//  UTC Year            2002        UTC year (4 digit format)
//  Local zone hours	00          Offset to local time zone in hours (+/- 00 to +/- 59)
//  Local zone minutes	00          Offset to local time zone in minutes (00 to 59)
//  Checksum            *6A
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class ZDA: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
