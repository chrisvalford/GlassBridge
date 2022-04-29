//
//  GPSView+Observed.swift
//  GlassBridge
//
//  Created by Christopher Alford on 29/4/22.
//

import Combine
import SwiftUI

extension GPSView {
    class Observed: ObservableObject {
        @Published var gllLatitude: Double = 0.0
        @Published var gllLongitude: Double = 0.0
        
        @Published var rmcLatitude: Double = 0.0
        @Published var rmcLongitude: Double = 0.0
        @Published var rmcLatitudeDirection: String = ""
        @Published var rmcLongitudeDirection: String = ""
        @Published var rmcSogKn: Double = 0
        
        init() {
            do {
                let gll = try GLL(rawData:"$GPGLL,6004.4083,N,01940.5157,E,094140,A,D*4D")
                gllLatitude = gll.latitude
                gllLongitude = gll.longitude
                
                let rmc = try RMC(rawData:"$GPRMC,094144,A,0004.4087,N,0004.5195,W,1.7,74.9,030610,4.8,E,D*2B")
                rmcLatitude = rmc.latitiue
                rmcLongitude = rmc.longitude
                rmcLatitudeDirection = rmc.latitudeDirection
                rmcLongitudeDirection = rmc.longitudeDirection
                rmcSogKn = rmc.sogKn.doubleValue
            } catch {
                print(error)
            }
        }
    }
}
