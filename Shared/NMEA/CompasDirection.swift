//
//  CompasDirection.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

enum CompasDirection: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case unknown = "U"

    func description() -> String {
        switch self {
        case .north:
            return "North"
        case .south:
            return "South"
        case .east:
            return "East"
        case .west:
            return "West"
        case .unknown:
            return "Unknown"
        }
    }
}
