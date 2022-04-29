//
//  TCPConnection.swift
//  XBridge
//
//  Created by Christopher Alford on 01.05.20.
//  Copyright © 2020 Digital+Marine. All rights reserved.
//

import Foundation

protocol TCPConnection: AnyObject {
    func error(_ message: String)
    func received(_ message: String)
    func status(_ message: String)
}
