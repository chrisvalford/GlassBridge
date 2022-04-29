//
//  NMEAError.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

enum NMEAError: Error {
    case invalidSentance
    case missingAttribute(_ named: String)
    case formatError
}
