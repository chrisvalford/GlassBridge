//
//  ChartCoordinate.swift
//  RasterView
//
//  Created by Christopher Alford on 06.06.20.
//  Copyright © 2020 marine+digital. All rights reserved.
//

import Foundation
import CoreLocation

extension ChartCoordinate {

    func locationDegreesFrom(DDD: String, MM: String, SS: String) -> CLLocationDegrees {

        let dd = Double(DDD)
        let md = Double(MM)
        let sd = Double(SS)
        var doubleValue = dd
        doubleValue = doubleValue! + (md! / 60)
        doubleValue = doubleValue! + (sd! / 3600)
        return CLLocationDegrees(doubleValue!) //.rounded(toPlaces: 3))
    }

    func degreesDecimalMinutes(number: NSDecimalNumber) -> (degrees: Int, decimalMinutes: Double) {
        let d = number.intValue
        let m = number.subtracting(NSDecimalNumber(value: d)).multiplying(by: 60)
        return (d, m.doubleValue)
    }

    func sanityCheck(number: NSDecimalNumber) {
        let d = number.intValue
        let m: NSDecimalNumber = number.subtracting(NSDecimalNumber(value: d)).multiplying(by: 60)
        let s: NSDecimalNumber = number.subtracting(NSDecimalNumber(value: d)).subtracting(m).dividing(by: 60).multiplying(by: 3600)
        //let s = (number - d - m/60) × 3600
        print("\(d)º \(m)\' \(s)\"")
    }

    // let decimalMinutes = dddmmtt(ddd: "08", mm: "10", tt: "30")
    // returns 490.3
    func dddmmtt(ddd: String, mm: String, tt: String) -> Double {
        var degreesString = "0"
        var minutesString = "0"
        var secondsString = "0"
        if !ddd.isEmpty { degreesString = ddd }
        if !mm.isEmpty { minutesString = mm }
        if !tt.isEmpty { secondsString = tt }
        var s: String
        if !secondsString.contains(".") {
            s = ".".appending(secondsString)
        } else {
            s = secondsString
        }
        var minutes = Double(minutesString)!
        minutes += Double(s)!
        minutes += Double(degreesString)! * Double(60)
        return minutes
    }

    // print(dmsToString(minutes: 490.3))
    // returns 8º 10.3'
    func dmsToString(minutes: Double) -> String {
        let d = Int(minutes / 60)
        let m = Int(minutes - (Double(d) * 60))
        let s = modf(minutes - (Double(d) * 60))
        var s2 = round(1000*s.1)/1000
        s2 += Double(m)
        return "\(d)º \(s2)\'"
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
