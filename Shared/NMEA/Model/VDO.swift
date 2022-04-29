//
//  VDO.swift
//  XBridge10
//
//  $GP
//  VDO - AIS VHF Datalink Own-vessel Message. 
//  AIS NMEA sentence that contains data about own ship.
//  Information: http://gpsd.berlios.de/AIVDM.html
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class VDO: NMEA0813Base {

   override init(rawData: String) throws {
      do {
          try super.init(rawData: rawData)
      }
   }
}
