//
//  GPSTextViewController.swift
//  GlassBridge
//
//  Created by Christopher Alford on 02.06.20.
//

import AppKit
import Combine

extension Notification.Name {
    static let sentenceReceived = Notification.Name("sentenceReceived")
}

class GPSTextViewController: NSViewController {

    @IBOutlet weak var gpsTime: NSTextFieldCell!
    @IBOutlet weak var gpsDate: NSTextField!
    @IBOutlet weak var localTime: NSTextField!
    @IBOutlet weak var localDate: NSTextField!
    @IBOutlet weak var latitude: NSTextField!
    @IBOutlet weak var longitude: NSTextField!
    @IBOutlet weak var hdg: NSTextField!
    @IBOutlet weak var cog: NSTextField!
    @IBOutlet weak var sog: NSTextField!
    @IBOutlet weak var tmg: NSTextField!
    @IBOutlet weak var stw: NSTextField!
    @IBOutlet weak var aws: NSTextField!
    @IBOutlet weak var tws: NSTextField!
    @IBOutlet weak var twa: NSTextField!
    @IBOutlet weak var twd: NSTextField!
    @IBOutlet weak var depth: NSTextField!
    @IBOutlet weak var gpsSource: NSTextField!
    @IBOutlet weak var gpsStatus: NSTextField!
    @IBOutlet weak var aisStatus: NSTextField!
    @IBOutlet weak var logStatus: NSTextField!

    var sentenceProcessor = SentanceProcessor.shared
    var rma: AnyCancellable? // RMA
    var rmc: AnyCancellable? // RMC
    var gll: AnyCancellable? // GLL
    var gsa: AnyCancellable? // GSL

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        rmc = sentenceProcessor.$rmc.sink(receiveValue: { rmc in
            if let _ = rmc {
                let dateTime = rmc?.utcDateTime
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .none
                self.gpsDate.stringValue = dateFormatter.string(from: dateTime!)

                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                timeFormatter.locale = Locale(identifier: "UTC")
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .long
                self.gpsTime.stringValue = timeFormatter.string(from: dateTime!)

                if let string = rmc?.dataStatus {
                    self.gpsStatus.stringValue = string
                }

                if let sog = rmc?.sogKn {
                    self.sog.stringValue = sog.description + " kn"
                }

                if let tmg = rmc?.tmgTrue {
                    self.tmg.stringValue = tmg.description + "º T"
                }

                if let latitude = rmc?.latitiue,
                    let direction = rmc?.latitudeDirection {
                    let string = latitude.dmsString(padded: true) + " \(direction)"
                    self.latitude.stringValue = string
                }

                if let longitude = rmc?.longitude,
                    let direction = rmc?.longitudeDirection {
                    let string = longitude.dmsString(padded: true) + " \(direction)"
                    self.longitude.stringValue = string
                }
            }
        })

        rma = sentenceProcessor.$rma.sink(receiveValue: { rma in
            if let sog = rma?.speedOverGround {
                self.sog.stringValue = sog.description + " kn"
            }
            if let cog = rma?.courseOverGround {
                self.cog.stringValue = cog.description + " º T"
            }
        })

        gsa = sentenceProcessor.$gsa.sink(receiveValue: { gsa in
            if gsa == nil {
                return
            }
            print("==== GPGSA ====")
            print("\(String(describing: gsa?.modeString))")
            print("\(String(describing: gsa?.modeNumber))")
            var prnLoop = 1
            for prn in (gsa?.prns)! {
                if prn != nil {
                    print("prn[\(prnLoop)] : \(prn)")
                }
                prnLoop += 1
            }
            print("\(String(describing: gsa?.pdop))")
            print("\(String(describing: gsa?.hdop))")
            print("\(String(describing: gsa?.vdop))")
            print("==============")
        })
    }

}


// RMC
/*
 @Published var variation: NSDecimalNumber = 0 // (Easterly var. subtracts from true course)
 @Published var variationDirection: String = "" // E or W
 @Published var modeIndicator: String = ""
 */

// RMA
/*
 var status: String? // A or V
    var latitude: CLLocationDegrees?
    var northSouth: String?
    var longitude: CLLocationDegrees?
    var eastWast: String?
    var variation: NSDecimalNumber?
    var variationDirection: String? // E or W
 */
