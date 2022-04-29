//
//  UInt8+.swift
//  ExpandFormat
//
//  Created by Christopher Alford on 25/4/22.
//

import Foundation

public extension UInt8 {
    var isNumber: Bool {
        if (48...57).contains(self) {
            return true
        }
        return false
    }
}
