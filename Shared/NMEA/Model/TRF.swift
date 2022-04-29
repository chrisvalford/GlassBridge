//
//  TRF.swift
//  XBridge10
//
//  $GP
//
//  TRF - TRANSIT Fix Data
//
//  Time, date, position, and information related to a TRANSIT Fix. 
//  The $GPTRF and $GPGXA sentences became obsolete when the TRANSIT satellite navigation system 
//  was replaced with GPS in 1996, refer to Wikipedia for further details.

//  $--TRF,hhmmss.ss,xxxxxx,llll.ll,a,yyyyy.yy,a,x.x,x.x,x.x,x.x,xxx
//  hhmmss.ss = UTC of position fix
//  xxxxxx = Date: dd/mm/yy
//  llll.ll,a = Latitude of position fix, N/S
//  yyyyy.yy,a = Longitude of position fix, E/W
//  x.x = Elevation angle
//  x.x = Number of iterations
//  x.x = Number of Doppler intervals
//  x.x = Update distance, nautical miles
//  x.x = Satellite ID
//
//  Created by Christopher Alford on 28/08/14.
//  Copyright (c) 2014 Yachtech. All rights reserved.
//

import Foundation

class TRF: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
