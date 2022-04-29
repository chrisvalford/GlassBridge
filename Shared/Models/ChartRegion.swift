//
//  ChartRegion.swift
//  GlassBridge
//
//  Created by Christopher Alford on 20.06.20.
//  Copyright © 2020 marine+digital. All rights reserved.
//

import Foundation

/// Describes Latitude and Longitude for chart extents
/// LH, RH, TOP, BOTTOM
enum ChartRegion: Int, CaseIterable {
    case NNWW = 0
    case NNEE = 1
    case SSWW = 2
    case SSEE = 3
    case NNWE = 4
    case SSWE = 5
    case NSWE = 6
    case NSWW = 7
    case NSEE = 8

    var description : String {
        switch self {
        case .NNWW: return "Northern hemisphere, west of prime meridian"
        case .NNEE: return "Northern hemisphere, east of prime meridian"
        case .SSWW: return "Southern hemisphere, west of prime meridian"
        case .SSEE: return "Southern hemisphere, east of prime meridian"
        case .NNWE: return "Northern hemisphere, crossing the prime meridian"
        case .SSWE: return "Southern hemisphere, crossing the prime meridian"
        case .NSWE: return "On the equator, crossing the prime meridian"
        case .NSWW: return "On the equator, west of prime meridian"
        case .NSEE: return "On the equator, east of prime meridian"
        }
    }

    init?(withDescription description: String) {
        guard let chartRange = ChartRegion.allCases.first( where: {
            let text = $0.description
            return text == description
        }) else { return nil }
        self = chartRange
    }

    static var allCasesDescriptions: [String] {

        return ChartRegion.allCases.compactMap { $0.description }
    }
}
