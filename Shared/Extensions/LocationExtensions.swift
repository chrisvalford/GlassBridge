//
//  LocationExtensions.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.06.20.
//

import Foundation
import CoreLocation

extension CLLocationDegrees {

    enum LocationConversion : Error {
        case invalidComponentCount
        case ambigiousFirstValue
        case invalidDegreeValue
        case invalidMinuteValue
        case invalidSecondValue
        case valueOverflow
    }

    init(DDMMmm: String) throws {
        self.init()
        let components = DDMMmm.components(separatedBy: ".")
        var degrees = Double(0)
        var minutes = Double(0)

        if components.count != 2 {
            throw LocationConversion.invalidComponentCount
        }
        if components[0].count == 5, let d = Double(String(components[0][...2])) {
            if d > 180 {
                throw LocationConversion.invalidDegreeValue
            }
            degrees = d
        }
        else if components[0].count == 4, let d = Double(String(components[0][...1])) {
            degrees = d
        } else {
            throw LocationConversion.ambigiousFirstValue
        }
        if let m = Double(String(components[0].suffix(2))) {
            minutes = m
            if m > 60 {
                throw LocationConversion.invalidMinuteValue
            }
        } else {
            throw LocationConversion.invalidMinuteValue
        }
        if let m = Double("."+String(components[1])) {
            minutes += m
            if m > 60 {
                throw LocationConversion.invalidMinuteValue
            }
        } else {
            throw LocationConversion.invalidMinuteValue
        }
        self = degrees + minutes / 60
    }

    func dmsString(padded: Bool) -> String {
        let d = Int(self)
        let m = Int((self - Double(d)) * 60)
        let s = ((self - Double(d) - Double(m)/60) * 3600).rounded()
        if padded == true {
            var degrees = String(d)
            while degrees.count < 3 {
                degrees.insert("0", at: degrees.startIndex)
            }

            var minutes = String(m)
            while minutes.count < 2 {
                minutes.insert("0", at: minutes.startIndex)
            }

            var seconds = String(s)
            while seconds.count < 2 {
                seconds.insert("0", at: seconds.startIndex)
            }

            return "\(degrees)º \(minutes)\' \(seconds)\""
        }
        return "\(d)º \(m)\' \(s)\""
    }

    func dms() -> (Int, Int, Double) {
        let d = Int(self)
        let m = Int((self - Double(d)) * 60)
        let s = ((self - Double(d) - Double(m)/60) * 3600).rounded()
        return (d, m, s)
    }

}
