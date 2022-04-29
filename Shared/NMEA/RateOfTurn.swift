//
//  RateOfTurn.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

/*
 Turn rate is encoded as follows:

 0 = not turning
 1…​126 = turning right at up to 708 degrees per minute or higher
 1…​-126 = turning left at up to 708 degrees per minute or higher
 127 = turning right at more than 5deg/30s (No TI available)
 -127 = turning left at more than 5deg/30s (No TI available)
 128 (80 hex) indicates no turn information available (default)

 Values between 0 and 708 degrees/min coded by ROTAIS=4.733 * SQRT(ROTsensor) degrees/min where ROTsensor is the Rate of Turn as input by an external Rate of Turn Indicator. ROTAIS is rounded to the nearest integer value. Thus, to decode the field value, divide by 4.733 and then square it. Sign of the field value should be preserved when squaring it, otherwise the left/right indication will be lost.
 */
enum RateOfTurn {

    case notTurning
    case turningRightAt708
    case turningLeftAt708
    case turningRightAt5Per30
    case turningLeftAt5Per30
    case noTurnData

    init(rawValue: Int) {
        if rawValue == 0 {
            self = .notTurning
        } else if (rawValue >= 1 && rawValue <= 126) {
            self = .turningRightAt708
        } else if (rawValue >= -126 && rawValue <= -1) {
            self = .turningLeftAt708
        } else if rawValue == 127 {
            self = .turningRightAt5Per30
        } else if rawValue == -127 {
            self = .turningLeftAt5Per30
        } else if rawValue == 128 {
            self = .noTurnData
        }
        else {
            self = .noTurnData
        }
    }

    func description() -> String {
        switch self {
        case .notTurning:
            return "Not turning"
        case .turningRightAt708:
            return "Turning right at up to 708 degrees per minute or higher"
        case .turningLeftAt708:
            return "Turning left at up to 708 degrees per minute or higher"
        case .turningRightAt5Per30:
            return "Turning right at more than 5deg/30s (No TI available)"
        case .turningLeftAt5Per30:
            return "Turning left at more than 5deg/30s (No TI available)"
        case .noTurnData:
            return "No turn information available"
        }
    }
}
