//
//  Exceptions.swift
//  ISO8211Reader
//
//  Created by Christopher Alford on 28/1/22.
//

import Foundation

public enum Exception: Error {
    case IOException
    case ArrayIndexOutOfBoundsException
    case NumberFormatException
    case InvalidCharException
}
