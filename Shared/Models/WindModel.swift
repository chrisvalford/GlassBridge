//
//  WindModel.swift
//  GlassBridge
//
//  Created by Christopher Alford on 03.06.20.
//

import Foundation
import Combine

struct WindModel {

    var lastWindObject: WindObject

    init(angle: Double, trueMagnetic: String, onBow: String, velocity: String, velocityUnit: String) {
        lastWindObject = WindObject(angle: angle, trueMagnetic: trueMagnetic, onBow: onBow, velocity: velocity, velocityUnit: velocityUnit)
    }

}

public struct WindObject: Decodable {
    var angle: Double
    var trueMagnetic: String
    var onBow: String // Port or Stbd
    var velocity: String
    var velocityUnit: String
}
