//
//  GNS.swift
//  XBridge10
//
//  $GP
//
//  GNS - GNSS fixed data
//
//             1         2          3           4    5  6   7   8   9   10  11
//  |         |          |           |    |  |   |   |   |   |   |
//      $--GNS,hhmmss.ss,llll.lll,a,yyyyy.yyy,a,c--c,xx,x.x,x.x,x.x,x.x,x.x*hh<CR><LF>
//
//  Field Number:
//  1) UTC of position
//  2) Latitude, N/S
//  3) Longitude, E/W
//  4) Mode indicator
//  5) Total number of satllite in use,00-99
//  6) HDOP
//  7) Antenna altitude, metres, re:mean-sea-level(geoid)
//  8) Geoidal separation
//  9) Age of differential data
//  10) Differential reference station ID
//  11) Checksum
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GNS: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }
}
