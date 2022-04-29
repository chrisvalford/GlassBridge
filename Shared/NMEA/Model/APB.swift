//
//  APB.swift
//  XBridge10
//
//  $GP
//  APB - Autopilot format "B"
//
//  This sentence is sent by some GPS receivers to allow them to be used to control an autopilot unit. 
//  This sentence is commonly used by autopilots and contains navigation receiver warning flag status,
//  cross-track-error, waypoint arrival status, initial bearing from origin waypoint to the destination,
//  continuous bearing from present position to destination and recommended heading-to-steer to
//  destination waypoint for the active navigation leg of the journey.

//  Note: Some autopilots, Robertson in particular, misinterpret "bearing from origin to destination" 
//  as "bearing from present position to destination". This is likely due to the difference between the 
//  APB sentence and the APA sentence. for the APA sentence this would be the correct thing to do for the 
//  data in the same field. APA only differs from APB in this one field and APA leaves off the last 
//  two fields where this distinction is clearly spelled out. This will result in poor performance if 
//  the boat is sufficiently off-course that the two bearings are different.

//  $GPAPB,A,A,0.10,R,N,V,V,011,M,DEST,011,M,011,M*3C

//  where:
//  APB     Autopilot format B
//  A       Loran-C blink/SNR warning, general warning
//  A       Loran-C cycle warning
//  0.10    cross-track error distance
//  R       steer Right to correct (or L for Left)
//  N       cross-track error units - nautical miles (K for kilometers)
//  V       arrival alarm - circle
//  V       arrival alarm - perpendicular
//  011,M   magnetic bearing, origin to destination
//  DEST    destination waypoint ID
//  011,M   magnetic bearing, present position to destination
//  011,M   magnetic heading to steer (bearings could True as 033,T)
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class APB: NMEA0813Base {
    
    override init(rawData: String) throws {

        do {
            try super.init(rawData: rawData)
        }
    }
}
