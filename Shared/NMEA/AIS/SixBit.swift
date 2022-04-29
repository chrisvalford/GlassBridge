//
//  SixBit.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

class SixBit {

    var sourceData = Array("".utf8)
    var binaryString = ""

    /*
     let source = "133m@ogP00PD;88MD5MTDww@2D7k"
     let source2 = "177KQJ5000G?tO`K>RA1wUbN0TKH"
     let source3 = "13FB78000009vH6Gc4v@b3iH05Ph"

     let msg = AIVDM(SixBit.binaryString)
     print("messageType: \(msg.messageType as Any)")
     print("repeatIndicator: \(msg.repeatIndicator as Any)")
     print("mmsi: \(msg.mmsi as Any)")
     print("navigationStatus: \(msg.navigationStatus.description())")
     print("rateOfTurn: \(msg.rateOfTurn.description())")
     print("speedOverGround: \(msg.speedOverGround.description())")
     print("positionAccuracy: \(msg.positionAccuracy as Any)")
     print("longitude: \(msg.longitude.description())")
     print("latitude: \(msg.latitude.description())")
     print("courseOverGround: \(msg.courseOverGround)°")
     print("trueHeading: \(msg.trueHeading as Any)")
     print("timeStamp: \(msg.timeStamp as Any)")
     print("maneuvertIndicator: \(msg.maneuvertIndicator as Any)")
     print("spare: \(msg.spare as Any)")
     print("raimFlag: \(msg.raimFlag as Any)")
     print("radioStatus: \(msg.radioStatus as Any)")

     */
    init(binaryData: String) {
        self.sourceData = Array(binaryData.utf8)
        for c in self.sourceData {
            let r1 = toDecimal(messageCharacter: c)
            let str = String(r1, radix: 2)
            binaryString.append(pad(string: str, toSize: 6))
        }
    }

    func pad(string : String, toSize: Int) -> String {
        var padded = string
        for _ in 0..<(toSize - string.count) {
            padded = "0" + padded
        }
        return padded
    }

    func toDecimal(messageCharacter: UInt8) -> Int {
        var n = messageCharacter - 48
        if n <= 40 {
            return Int(n)
        }

        if n > 40 {
            n -= 8
            return Int(n)
        }
        return Int(messageCharacter)
    }

}

/*
 Longitude is given in in 1/10000 min; divide by 600000.0 to obtain degrees. Values up to plus or minus 180 degrees, East = positive, West \= negative. A value of 181 degrees (0x6791AC0 hex) indicates that longitude is not available and is the default.
 */
struct Longitude {
    var value: Double
    var isAvailable: Bool
    var direction = CompasDirection.unknown

    init(_ longitude: Double, mode: String = "big") {

        //var _past180 = false

        if mode == "big" && longitude >= 180 {
            //_past180 = true
            let difference = longitude - 180
            value = 180 - difference
            direction = .west
            isAvailable = true
        } else if mode == "big" && longitude <= 180{
            value = longitude
            direction = .east
            isAvailable = true
        } else {
            if longitude >= 181 {
                self.value = 0
                self.isAvailable = false
                self.direction = .unknown
            } else {
                self.value = longitude
                self.isAvailable = true
                if longitude >= 0 {
                    self.direction = .east
                } else {
                    self.direction = .west
                }
            }
        }
    }

    func description() -> String {
        if isAvailable == false {
            return "Unknown"
        }
        let degrees = Int(value)
        let remainder = value.truncatingRemainder(dividingBy: 6)
        //FIXME: Direction is not showing
        print("Direction: \(self.direction.description())")
        return String(format: "%d° %.4f' %*", degrees, remainder, self.direction.description())
    }
}


/*
 Latitude is given in in 1/10000 min; divide by 600000.0 to obtain degrees. Values up to plus or minus 90 degrees, North = positive, South = negative. A value of 91 degrees (0x3412140 hex) indicates latitude is not available and is the default.
 */
struct Latitude {

    enum MeasurementReference {
        case long360, long180
    }

    var value: Double
    var isAvailable: Bool
    var direction: CompasDirection
    var _latitude = Double(0)

    init(_ latitude: Double, reference: MeasurementReference) {
        if reference == .long360 && latitude >= 90 {
            _latitude = latitude - 90
        } else {
            _latitude = latitude
        }

        if _latitude >= 91 {
            self.value = 0
            self.isAvailable = false
            self.direction = .unknown
        } else {
            self.value = latitude
            self.isAvailable = true
            if _latitude >= 0 {
                self.direction = .north
            } else {
                self.direction = .south
            }
        }
    }

    func description() -> String {
        if isAvailable == false {
            return "Unknown"
        }
        let degrees = Int(value)
        let remainder = value.truncatingRemainder(dividingBy: 1) * 10
        //FIXME: Direction is not showing
        return String(format: "%d° %.4f' %*", degrees, remainder, self.direction.description())
    }
}

