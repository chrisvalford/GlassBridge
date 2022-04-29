//
//  VWT.swift
//  XBridge10
//
//  VWT - True Wind Speed and Angle
//
//  True wind angle in relation to the vessel's heading and true wind speed referenced to the water. 
//  True wind is the vector sum of the Relative (Apparent) wind vector and the vessel's
//  velocity vector relative to the water along the heading line of the vessel. It represents
//  the wind at the vessel if it were stationary relative to the water and heading in the
//  same direction.
//
//  ￼￼￼The use of $--MWV is recommended.
//      $--VWT,x.x,a,x.x,N,x.x,M,x.x,K*hh<CR><LF>
//
//  x.x Calculated wind angle relative to the vessel, 0 to 180
//  a   left/right L/R of vessel heading
//  x.x Calculated wind Speed
//  N   knots
//  x.x Wind speed
//  M   meters/second
//  x.x Wind speed
//  K   Km/Hr
//
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class VWT: NMEA0813Base {
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
    }

}
