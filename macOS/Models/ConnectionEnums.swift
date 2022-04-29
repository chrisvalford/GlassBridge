//
//  Enums.swift
//  GlassBridge
//
//  Created by Christopher Alford on 1/3/22.
//

import Foundation

enum BaudRate: Int, CaseIterable, Identifiable {
    case bu4800 = 4800
    case bu9600 = 9600
    case bu19200 = 19200
    case bu38400 = 38400
    
    var string: String {
        switch self {
        case .bu4800:
            return "4800"
        case .bu9600:
            return "9600"
        case .bu19200:
            return "19200"
        case .bu38400:
            return "38400"
        }
    }
    
    var id: Int {
        return self.rawValue
    }
}

//    var baudRates: [String] {
//        return BaudRate.allCases.map {
//            $0.string
//        }
//    }

enum Parity: String, CaseIterable, Identifiable {
    case none
    case odd
    case even
    case mark
    case space
    
    var id: String {
        return self.rawValue
    }
}

enum Bits: Int, CaseIterable, Identifiable {
    case bi7 = 7
    case bi8 = 8
    
    var id: Int {
        return self.rawValue
    }
    
    var string: String {
        switch self {
        case .bi7:
            return "7"
        case .bi8:
            return "8"
        }
    }
}

enum StopBits: Float, CaseIterable, Identifiable {
    case sb0 = 0.0
    case sb1 = 1.0
    case sb15 = 1.5
    case sb2 = 2.0
    
    var string: String {
        switch self {
        case .sb0:
            return "0"
        case .sb1:
            return "1"
        case .sb15:
            return "1.5"
        case .sb2:
            return "2"
        }
    }
    
    var id: Float {
        return self.rawValue
    }
}

enum ConnectionDirection: String, CaseIterable, Identifiable  {
    case inbound
    case outbound
    case biDirectional
    
    var id: String {
        return self.rawValue
    }
}
