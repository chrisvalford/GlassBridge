//
//  SOG.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

/*
 Speed over ground is in 0.1-knot resolution from 0 to 102 knots. Value 1023 indicates speed is not available, value 1022 indicates 102.2 knots or higher.
 */
struct SOG {
    var value: Double
    var isAvailable: Bool

    init(_ value: Int) {
        if value >= 1023 {
            self.value = 0
            self.isAvailable = false
        } else {
            self.value = Double(value) / 10
            self.isAvailable = true
        }
    }

    func description() -> String {
        if isAvailable {
            if value == 0 {
                return "Stationary"
            }
            return "\(value) knots"
        } else {
            return "Not available"
        }
    }
}
