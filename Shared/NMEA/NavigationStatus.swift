//
//  NavigationStatus.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

enum NavigationStatus: Int {
    case underWayUsingEngine = 0
    case atAnchor = 1
    case notUnderCommand = 2
    case restrictedManoeuverability = 3
    case constrainedByDraught = 4
    case moored = 5
    case aground = 6
    case engagedInFishing = 7
    case underWaySailing = 8
    case reservedHSC = 9
    case reservedWIG = 10
    case reservedForFutureUse1 = 11
    case reservedForFutureUse2 = 12
    case reservedForFutureUse3 = 13
    case aisSartIsActive = 14
    case notDefined = 15

    func description() -> String {
        switch self {
        case .underWayUsingEngine:
            return "Under way - Using engine"
        case .atAnchor:
            return "At anchor"
        case .notUnderCommand:
            return "Not under command"
        case .restrictedManoeuverability:
            return "Restricted manoeuverability"
        case .constrainedByDraught:
            return "Constrained by draught"
        case .moored:
            return "Moored"
        case .aground:
            return "Aground"
        case .engagedInFishing:
            return "Engaged nn fishing"
        case .underWaySailing:
            return "Under way - Sailing"
        case .reservedHSC:
            return "Reserved for future amendment of Navigational Status for HSC"
        case .reservedWIG:
            return "Reserved for future amendment of Navigational Status for WIG"
        case .reservedForFutureUse1:
            return "Reserved for future use"
        case .reservedForFutureUse2:
            return "Reserved for future use"
        case .reservedForFutureUse3:
            return "Reserved for future use"
        case .aisSartIsActive:
            return "AIS-SART is active"
        case .notDefined:
            return "Not defined"
        }
    }
}
