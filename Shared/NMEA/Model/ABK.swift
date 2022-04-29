//
//  ABK.swift
//  XBridge10
//
//  $GP
//  ABK - UAIS Addressed and binary broadcast acknowledgement
//
//          1         2 3   4 5
//  |         | |   | |
//      $--ABK,xxxxxxxxx,a,x.x,x,x*hh<CR><LF>
//
//  Field Number:
//  1) MMSI of the addressed AIS unit
//  2) AIS chanel of receeption
//  3) ITU-R M.1371 Message ID
//  4) Message sequence number
//  5) Type of acknowledgement
//
//  Created by Christopher Alford on 14/02/15.
//  Copyright (c) 2015 Yacht Tech EU. All rights reserved.
//

import Foundation

class ABK: NMEA0813Base {

    var mmsiOfTheAddressedAISUnit: String?
    var aisChanelOfReception: String?
    var ITU_R_M_1371MessageId: String?
    var messageSequenceNumber: String?
    var typeOfAcknowledgement: String?
    
    override init(rawData: String) throws {

       do {
           try super.init(rawData: rawData)
       }
        self.mmsiOfTheAddressedAISUnit = String(bytes: attributes[1], encoding: .utf8)
        self.aisChanelOfReception = String(bytes: attributes[2], encoding: .utf8)
        self.ITU_R_M_1371MessageId = String(bytes: attributes[3], encoding: .utf8)
        self.messageSequenceNumber = String(bytes: attributes[4], encoding: .utf8)
        self.typeOfAcknowledgement = String(bytes: attributes[5], encoding: .utf8)

//        if let string = String(bytes: attributes[3], encoding: .utf8) {
//            self.circleRadius = NSDecimalNumber(string: string)
//        } else {
//            return nil
//        }
    }
}
