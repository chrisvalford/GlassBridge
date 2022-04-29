//
//  Conversions.swift
//  GlassBridge
//
//  Created by Christopher Alford on 03.06.20.
//

import Foundation

func ddMMmm(data: String) -> Decimal? {
    var result = Decimal(0)

    // Split at the .
    let components = data.components(separatedBy: ".")
    //dd is 2 chars? representing degrees
    if components[0].count > 3 { return nil }
    //MM is  minutes

    //mm is the minutes decimal part

    //result = degrees + minutes / 60
    return result
}
