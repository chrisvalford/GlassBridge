//
//  CChar+.swift
//  ExpandFormat
//
//  Created by Christopher Alford on 25/4/22.
//

import Foundation

extension CChar {
    public func isDigit() -> Bool {
        return CChar(48) ... CChar(57) ~= self
    }
    
    public func isAlpha() -> Bool {
        var isAlpha = false
        if CChar(97) ... CChar(122) ~= self {
           isAlpha = true
        }
        
        else if CChar(65) ... CChar(90) ~= self {
            isAlpha = true
        }
        return isAlpha
    }
}

/*
let s = "Az09"
let c = "A"
let cca = s.cString(using: String.Encoding.utf8)


cca![0].isDigit()
cca![0].isAlpha()
cca![1].isDigit()
cca![1].isAlpha()
cca![2].isDigit()
cca![2].isAlpha()
cca![3].isDigit()
cca![3].isAlpha()

let cc = c.cString(using: String.Encoding.utf8)!
cc[0].isAlpha()
*/
