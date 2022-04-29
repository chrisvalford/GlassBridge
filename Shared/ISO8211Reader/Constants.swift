//
//  Constants.swift
//  ExpandFormat
//
//  Created by Christopher Alford on 25/4/22.
//

import Foundation

let headerLength = 24

let fieldTerminator = UInt8(30)         // ASCII RS (Record separator 0x1E)
let unitTerminator = UInt8(31)          // ASCII US (Unit separator 0x1F)

let comma = UInt8(44)                   //Character(",").asciiValue!
let openingParenthesis = UInt8(40)      //Character("(").asciiValue!
let closingParenthesis = UInt8(41)      //Character(")").asciiValue!
let zero = UInt8(48)
let one = UInt8(49)
let two = UInt8(50)
let three = UInt8(51)
let upperA = UInt8(65)
let lowerB = UInt8(98)
let upperB = UInt8(66)
let upperC = UInt8(67)
let upperI = UInt8(73)
let upperL = UInt8(76)
let upperR = UInt8(82)
let upperS = UInt8(83)
let upperX = UInt8(88)
