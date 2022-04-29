//
//  GRS.swift
//  XBridge10
//
//  $GP
//
//  GRS - GPS Range Residuals
//
//  Example: $GPGRS,024603.00,1,-1.8,-2.7,0.3,,,,,,,,,*6C
//
//  Field           Example     Comments
//  Sentence ID     $GPGRS
//  UTC Time        024603.00	UTC time of associated GGA fix
//  Mode            1           0 = Residuals used in GGA, 1 = residuals calculated after GGA
//  Sat 1 residual	-1.8        Residual (meters) of satellite 1 in solution
//  Sat 2 residual	-2.7        The order matches the PRN numbers in the GSA sentence
//  Sat 3 residual	0.3
//  Sat 4 residual              Unused entries are blank
//  Sat 5 residual
//  Sat 6 residual
//  Sat 7 residual
//  Sat 8 residual
//  Sat 9 residual
//  Sat 10 residual
//  Sat 11 residual
//  Sat 12 residual
//  Checksum        *6C
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class GRS: NMEA0813Base {
    
    override init(rawData: String) throws {
       do {
           try super.init(rawData: rawData)
       }
    }
}
