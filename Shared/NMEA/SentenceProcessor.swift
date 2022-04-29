//
//  SentenceProcessor.swift
//  CombineTests
//
//  Created by Christopher Alford on 25.05.20.
//  Copyright © 2020 anapp4that. All rights reserved.
//

import Foundation
import Combine

class SentanceProcessor: ObservableObject {

    @Published var cog: NSDecimalNumber?
    @Published var sog: Decimal?
    @Published var headingMagnetic: ChartAngle?
    @Published var wind: WindModel?
    @Published var rma: RMA?
    @Published var rmc: RMC?
    @Published var gll: GLL?
    @Published var gsa: GSA?

    static let shared = SentanceProcessor()

    let nmea = ["$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,1.7,1.0,1.3*35","$GPGLL,6004.4083,N,01940.5157,E,094140,A,D*4D","$GPGGA,094140,6004.4083,N,01940.5157,E,2,10,1.0,0.1,M,21.7,M,,*4B","$IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52","$IIHDG,274,0.0,E,5.8,W*5F","$PGRMZ,0,f,3*1B","$GPRMC,094142,A,5958.4085,N,01940.5176,E,1.8,80.0,030610,4.8,E,D*2F","$PGRME,2.9,M,4.3,M,5.2,M*25",
                "$GPGLL,6004.4085,N,01940.5176,E,094142,A,D*4A","$GPGGA,094142,6004.4085,N,01940.5176,E,2,10,1.0,0.1,M,21.7,M,,*4C","$GPBOD,139.7,T,134.9,M,A002,A003*45","$GPRMB,A,0.20,R,A003,A002,6004.099,N,01940.515,E,0.310,180.3,-0.5,V,D*6C","$IIHDG,276,0.0,E,5.8,W*5F","$PGRME,3.0,M,4.2,M,5.3,M*2D",
                "$GPGGA,094142,6004.4085,N,01940.5176,E,2,10,1.0,0.1,M,21.7,M,,*4C","$GPRMC,094144,A,5959.4087,N,01940.5195,E,1.7,74.9,030610,4.8,E,D*2B","$PGRMZ,0,f,3*1B","$GPBOD,139.7,T,134.9,M,A002,A003*45",
                "$IIVWR,046.0,L,12.6,N,6.5,M,23.3,K*51",
                "$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,1.9,1.2,1.5*3F","$GPGLL,6004.4087,N,01940.5195,E,094144,A,D*43","$GPRMB,A,0.20,R,A003,A002,6004.099,N,01940.515,E,0.310,180.4,-0.5,V,D*6B","$IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52","$IIHDG,272,0.0,E,5.8,W*5F","$GPBOD,139.7,T,134.9,M,A002,A003*45","$PGRME,3.4,M,4.7,M,5.9,M*26",
                "$GPGGA,094144,6004.4087,N,01940.5195,E,2,10,1.2,0.2,M,21.7,M,,*44","$GPRMC,094146,A,6000.4089,N,01940.5214,E,1.7,75.7,030610,4.8,E,D*22","$GPRMB,A,0.20,R,A003,A002,6004.099,N,01940.515,E,0.310,180.6,-0.3,V,D*6F",
                "$GPGLL,6004.4089,N,01940.5214,E,094146,A,D*45","$GPGGA,094146,6004.4089,N,01940.5214,E,2,10,1.2,0.3,M,21.7,M,,*43","$IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52","$GPRMC,094148,A,6001.4090,N,01940.5232,E,1.7,79.4,030610,4.8,E,D*2F","$IIHDG,270,0.0,E,5.8,W*5F","$GPRMB,A,0.20,R,A003,A002,6004.099,N,01940.515,E,0.310,180.8,-0.4,V,D*66","$PGRME,3.5,M,4.9,M,6.1,M*22",
                "$GPGSA,A,3,,04,05,07,08,10,13,16,,29,,,2.7,1.6,2.2*31","$GPGGA,094148,6004.4090,N,01940.5232,E,2,10,1.4,0.5,M,21.7,M,,*41","$GPRMC,094150,A,6002.4092,N,01940.5251,E,1.7,76.3,030610,4.8,E,D*29","$GPBOD,139.7,T,134.9,M,A002,A003*45","$IIHDG,268,0.0,E,5.8,W*5F","$PGRMZ,1,f,3*1A","$GPBOD,139.7,T,134.9,M,A002,A003*45","$IIHDG,271,0.0,E,5.8,W*5F","$GPBOD,139.7,T,134.9,M,A002,A003*45",
                "$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,2.2,1.4,1.7*33","$IIHDG,273,0.0,E,5.8,W*5F","$PGRME,3.6,M,5.1,M,6.3,M*2A",
                "$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,2.0,1.2,1.6*36","$GPGLL,6004.4090,N,01940.5232,E,094148,A,D*47","$GPGGA,094150,6004.4092,N,01940.5251,E,2,10,1.5,0.6,M,21.7,M,,*4D","$GPRMC,094152,A,6003.4093,N,01940.5271,E,1.8,80.8,030610,4.8,E,D*25","$IIHDG,276,0.0,E,5.8,W*5F","$GPRMB,A,0.20,R,A003,A002,6004.099,N,01940.515,E,0.310,180.9,-0.3,V,D*60","$IIHDG,277,0.0,E,5.8,W*5F","$IIHDG,274,0.0,E,5.8,W*5F","$PGRME,3.6,M,5.4,M,6.5,M*29","$IIVWR,046.0,L,11.9,N,6.5,M,23.3,K*5D","$IIVWR,060.0,L,11.5,N,6.5,M,23.3,K*55",
                "$GPGGA,094152,6004.4093,N,01940.5271,E,2,07,1.5,0.7,M,21.7,M,,*4B","$IIHDG,278,0.0,E,5.8,W*5F","$PGRMZ,1,f,3*1A",
                "$GPGLL,6004.4092,N,01940.5251,E,094150,A,D*49","$GPGGA,094154,6004.4095,N,01940.5289,E,2,08,1.6,0.7,M,21.7,M,,*40","$GPRMC,094154,A,6004.4095,N,01940.5289,E,1.8,82.1,030610,4.8,E,D*29","$GPBOD,139.7,T,134.9,M,A002,A003*45","$IIVWR,060.0,L,11.5,N,6.5,M,23.3,K*55","$GPBOD,139.7,T,134.9,M,A002,A003*45","$IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52","$PGRME,3.9,M,6.1,M,7.3,M*27","$PGRMZ,2,f,3*19",
                "$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,1.7,1.0,1.4*32","$GPGLL,6004.4093,N,01940.5271,E,094152,A,D*48","$IIVWR,045.0,L,11.5,N,6.5,M,23.3,K*52","$GPRMB,A,0.21,R,A003,A002,6004.099,N,01940.515,E,0.310,181.1,-0.2,V,D*69","$IIHDG,272,0.0,E,5.8,W*5F",
                "$GPGSA,A,3,02,04,05,07,08,10,13,16,23,29,,,2.6,1.5,2.1*33","$GPRMB,A,0.21,R,A003,A002,6004.099,N,01940.515,E,0.311,181.3,-0.3,V,D*6B","$PGRMZ,2,f,3*19","$IIHDG,274,0.0,E,5.8,W*5F","$PGRME,3.4,M,6.2,M,7.3,M*29",
                "$GPGSA,A,3,,04,05,07,08,10,13,,,29,,,2.6,1.5,2.1*37","$IIHDG,270,0.0,E,5.8,W*5F","$PGRMZ,2,f,3*19","$IIVWR,060.0,L,11.5,N,6.5,M,23.3,K*55","$GPGLL,6004.4095,N,01940.5289,E,094154,A,D*4F"]

    @Published var sentence = ""

    var index = 0

    private init() {
        // Publisher: Uses a timer to emit the date once per second.
        //Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendNMEA), userInfo: nil, repeats: true)

        //Remove to ... later
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .sentenceReceived, object: nil)
    }

    var sentenceSegment = [CChar]()

    @objc func onDidReceiveData(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            let msg = data["sentence"] as? String
            print("Received: \(String(describing: msg))")

            if let cString = msg?.utf8CString {

                // Validate the CChars
                cString.withUnsafeBufferPointer { ptr in
                    if let s = String(validatingUTF8: ptr.baseAddress!) {
                        print("\(s) is VALID")
                    } else {
                        sentenceSegment.removeAll()
                        return
                    }
                }

                // Does this segment include the checksum? *nn
                let position = cString.lastIndex(of: CChar(42)) // *
                if position == (cString.count - 1) - 3 {
                    print("Contains checksum")
                    if !sentenceSegment.isEmpty {
                        sentenceSegment.append(contentsOf: Array(cString))
                    }
                } else {
                    sentenceSegment = Array(cString)
                }

                let str = String(cString: sentenceSegment)
                senderData(from: str) { (sender, identifier, error) in
                    if error != nil {
                        print(error as Any)
                    } else {
                        // Create a new ......
                        print("Sender: \(String(describing: sender)), identifier: \(String(describing: identifier))")
                    }
                }
            }

        }
    }

    @objc func sendNMEA() {
        senderData(from: nmea[index], {(senderId, sentenceId, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                switch sentenceId {
                case "ALM":
                    let _ = try ALM(rawData: nmea[index])

                case "BOD":
                    let _ = try BOD(rawData: nmea[index])

                case "GGA":
                    let _ = try GGA(rawData: nmea[index])

                case "GLL":
                    self.gll = try GLL(rawData: nmea[index])

                case "GSA":
                    self.gsa = try GSA(rawData: nmea[index])

                case "HDG":
                    let hdg = try HDG(rawData: nmea[index])
                    self.headingMagnetic = ChartAngle(magneticDegrees: hdg.headingDegrees,
                                                      variationDegrees: hdg.variationDegrees,
                                                      variationDirection: hdg.variationDirection,
                                                      deviationDegrees: hdg.deviationDegrees,
                                                      deviationDirection: hdg.deviationDirection,
                                                      calculateTrue: true)
                case "RMA":
                    self.rma = try RMA(rawData: nmea[index])

                case "RMB":
                    let _ = try RMB(rawData: nmea[index])

                case "RMC":
                    self.rmc = try RMC(rawData: nmea[index])

                case "RME":
                    let _ = try RME(rawData: nmea[index])

                case "RMZ":
                    let _ = try RMZ(rawData: nmea[index])

                case "VWR":
                    let data = try VWR(rawData: nmea[index])
                    let model =  WindModel(angle: data.windDirectionMagnitudeInDegrees!.doubleValue,
                                           trueMagnetic: "T",
                                           onBow: data.windDirectionLeftRightOfBow!,
                                           velocity: data.speedKnots!.description,
                                           velocityUnit: (data.knotsIndicator)!)
                    self.wind = model

                default:
                    break
                }
            } catch {
                print(error)
            }
        })
        index += 1
        if index == nmea.count {
            index = 0
        }
    }

    func senderData(from sentance: String, _ closure: (String?, String?, Error?) -> Void) {
        // Ignore the leading $
        let first = sentance.first //TODO: [0] is confused
        if first != "$" && first != "!" {
            closure(nil, nil, NMEAError.missingAttribute("$"))
        }
        let components = sentance.components(separatedBy: ",")
        if components.count < 2 {
            closure(nil, nil, NMEAError.invalidSentance)
        }
        let s = components[0]
        let sender = s[1...2]
        let identifier = s[3...]
        closure(String(sender), String(identifier), nil)
    }
}



 /*

 let nmea = [

 "$GPGSV,3,1,12,02,28,256,34,04,10,216,39,05,35,301,00,07,65,172,43*7A",
 "$GPGSV,3,2,12,08,33,205,43,10,61,267,42,13,52,094,49,16,22,035,43*73",

 "$GPGSV,3,3,12,23,27,095,39,29,08,329,37,37,21,178,38,39,24,173,00*7C",

 "$PGRMM,WGS 84*06",
 "$GPRTE,1,1,c,A003-A001 1,A003,A002,A001*54",

 "$GPGSV,3,1,12,02,28,256,34,04,10,216,39,05,35,301,00,07,65,172,42*7B",

 "$GPGSV,3,2,12,08,33,205,44,10,61,267,41,13,52,094,48,16,22,035,43*76",
 "$GPGSV,3,3,12,23,27,095,38,29,08,329,36,37,21,178,38,39,24,173,40*78",

 "$PGRMM,WGS 84*06",
 "$GPWPL,6004.407,N,01939.993,E,A003*39",

 "$GPGSV,3,1,12,02,28,256,00,04,10,216,38,05,35,301,31,07,65,172,43*7E",
 "$GPGSV,3,2,12,08,33,205,44,10,61,267,41,13,52,094,48,16,22,035,42*77",
 "$GPGSV,3,3,12,23,27,095,38,29,08,329,35,37,21,178,38,39,24,173,39*75",
 "$PGRMM,WGS 84*06",
 "$GPWPL,6004.099,N,01940.515,E,A002*37",

 "$GPGSV,3,1,12,02,28,256,00,04,10,216,37,05,35,301,34,07,65,172,42*75",
 "$GPGSV,3,2,12,08,33,205,44,10,61,267,42,13,52,094,48,16,22,035,40*76",

 "$GPGSV,3,3,12,23,27,095,40,29,08,329,34,37,21,178,38,39,24,173,38*7A",

 "$PGRMM,WGS 84*06",
 "$GPWPL,6003.958,N,01940.872,E,A001*3B",

 "$GPGSV,3,1,12,02,28,256,00,04,10,216,36,05,35,301,35,07,65,172,43*74",
 "$GPGSV,3,2,12,08,33,205,44,10,61,267,42,13,52,094,48,16,22,035,40*76",
 "$GPGSV,3,3,12,23,27,095,39,29,08,329,35,37,21,178,38,39,24,173,37*7A",
 "$PGRMM,WGS 84*06",
 "$GPRTE,1,1,c,A003-A001 1,A003,A002,A001*54",

 "$GPGSV,3,1,12,02,28,256,00,04,10,216,35,05,35,301,35,07,65,172,43*77",
 "$GPGSV,3,2,12,08,33,205,43,10,61,267,41,13,52,094,48,16,22,035,39*7C",
 "$GPGSV,3,3,12,23,27,095,39,29,08,329,35,37,21,178,38,39,24,173,38*75",

 "$PGRMM,WGS 84*06",
 "$GPWPL,6004.407,N,01939.993,E,A003*39",

 "$GPGSV,3,1,12,02,28,256,00,04,10,216,34,05,35,301,34,07,65,172,43*77",
 "$GPGSV,3,2,12,08,33,205,43,10,61,267,41,13,52,094,48,16,22,035,40*72",
 "$GPGSV,3,3,12,23,27,095,38,29,08,329,37,37,21,178,38,39,24,173,38*76",

 "$PGRMM,WGS 84*06",
 "$GPWPL,6004.099,N,01940.515,E,A002*37",


 "$GPGSV,3,1,12,02,28,256,00,04,10,216,33,05,35,301,34,07,65,172,43*70",
 "$GPGSV,3,2,12,08,33,205,42,10,61,267,41,13,52,094,48,16,22,035,41*72",
 "$GPGSV,3,3,12,23,26,095,37,29,08,329,36,37,21,178,38,39,24,173,37*76",

 "$PGRMZ,2,f,3*19"
*/


/**
 $IIMWD,046.5,T,046.5,M,9.3,N,4.8,M*42
 $IIVLW,3897.3,N,3.61,N*4F
 $IIVTG,104.5,T,104.5,M,8.1,N,15.0,K*64
 $IIBWC,050003,,,,,,T,,M,,N,*07
 $IIDBT,31.5,f,9.60,M,5.25,F*2B
 $IIGLL,5144.793,N,00100.028,E,050002,A,D*50
 $IIHDG,106.5,,,0,W*2C
 $IIHDM,106.5,M*20
 $IIHDT,106.5,T*20
 $IIRMC,050003,A,5144.792,N,00100.031,E,8.1,105.0,070616,0,W,D*03
 $IIMWV,315.0,R,12.6,N,A*0F
 $IIMWV,291.5,T,9.5,N,A*38
 $IIVHW,108.0,T,108.0,M,5.40,N,10.00,K*65
 $IIVPW,1.98,N,1.02,M*51

 $IIVWT,068.5,L,9.5,N,4.9,M,17.6,K*6B
 $IIBWC,050003,,,,,,T,,M,,N,*07
 $IIDBT,31.3,f,9.54,M,5.21,F*2E
 $IIGLL,5144.792,N,00100.031,E,050003,A,D*58
 $IIHDG,107.5,,,0,W*2D
 $IIHDM,107.5,M*21


 $IIVWR,045.0,L,12.6,N,6.5,M,23.3,K*52
 ,"$IIVWR,046.0,L,12.6,N,6.5,M,23.3,K*51"
 ,"$IIVWR,046.0,L,11.9,N,6.5,M,23.3,K*5D"
 ,"$IIVWR,045.0,L,11.5,N,6.5,M,23.3,K*52"
 */


/*
 !AIVDM,1,1,,A,137JlD51@0P9td0GbCM64hjB0@6A,0*22
 !AIVDM,1,1,,B,4028jJ1vDB<::09cHRGdh2g020S:,0*43
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1PR?,0*23
 !AIVDM,1,1,,A,B3EercP0=H2QPg5rpBNGSwV5oP06,0*25
 !AIVDM,1,1,,A,4028j;1vDB<:?09cI<Gdh=i005P`,0*04
 !AIVDM,1,1,,A,D028j;2<Tffp,0*23
 !AIVDM,1,1,,A,13E`ukgP00P:ljpGgHG=N?vP25P`,0*46
 !AIVDM,1,1,,A,D028jJ1TPN?b<`O6EqHO6D0,2*08
 !AIVDM,2,1,1,A,53E`ukT000000000000qDEH61HU8LDr0@Dj0l5801p533t0Ht00000000000,0*1E
 !AIVDM,2,2,1,A,00000000000,2*25
 !AIVDM,1,1,,A,D028ioiMdffp,0*6E
 !AIVDM,1,1,,B,137JlD5u00P9td8GbCMFDhj`0@<Q,0*25
 !AIVDM,1,1,,B,B3MA<Jh0002TAH5sFDoQ3wc1nE8J,0*2C
 !AIVDM,1,1,,A,B3GQLwP00@2T@>UsFAdw;wc5oP06,0*63
 !AIVDM,1,1,,B,13FB78000009vGlGc4whb3hj0<2b,0*78
 !AIVDM,1,1,,B,H028jJ0<thi<E8th40000000000,2*65
 !AIVDM,1,1,,B,B33nQpP0082T;7UsF>6dOwdVSP06,0*29
 !AIVDM,1,1,,B,4028j;1vDB<:I09cI:Gdh>i00<30,0*4E
 !AIVDM,1,1,,B,D028j;2<Tffp,0*20
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1W3h,0*12
 !AIVDM,1,1,,B,4028jJ1vDB<:N09cHVGdh6?020S:,0*6F
 !AIVDM,1,1,,B,13F:b60P0009wL<GblrVvwvv0@Bd,0*5B
 !AIVDM,1,1,,B,B4UgD@00002T<J5sDtFl7wi5WP06,0*34
 !AIVDM,1,1,,A,D028j;1Mdffp,0*61
 !AIVDM,1,1,,A,13E`ukgP00P:lk2GgHDMTww82<0w,0*33
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1PSD,0*5A
 !AIVDM,1,1,,B,13FEJ4<P00P9nehGb7dCmww>0HGM,0*28
 !AIVDM,1,1,,A,33etlR5001P9swrGbHlu6nOD0Dm:,0*16
 !AIVDM,1,1,,B,137JlD5vh0P9tdDGbCMoL0k@08H`,0*67
 !AIVDM,1,1,,B,13FB78000009vH4Gc4v@b3iH0<2b,0*25
 !AIVDM,1,1,,B,4028j;1vDB<:e09cI<GdhA1005P`,0*79
 !AIVDM,1,1,,B,D028j;1Mdffp,0*62
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1l1c,0*20
 !AIVDM,1,1,,B,4028jJ1vDB<:j09cHbGdh8?020S:,0*71
 !AIVDM,1,1,,B,;028j;1vDB<:k09cGtGdh5Q00000,0*1F
 !AIVDM,1,1,,A,;028j;1vDB<:k09cGtGdh5Q00000,0*1C
 !AIVDM,1,1,,B,13F:b60P0009wLNGblqFgOwV0D1v,0*57
 !AIVDM,1,1,,A,4028j;1vDB<:o09cI>GdhAQ008Pt,0*0B
 !AIVDM,1,1,,A,D028j;0flffp,0*43
 !AIVDM,1,1,,A,13E`ukgP00P:lk0GgHD00?wj2<10,0*74
 !AIVDM,1,1,,B,33etI<1001P:17fGadPTVIQl0Dg:,0*06
 !AIVDM,2,1,2,B,54i4b840?Km5`L9cR204<F22222222222222220U5@c7776i09iDp0Pk`888,0*4E
 !AIVDM,2,2,2,B,88888888880,2*25
 !AIVDM,1,1,,A,D028ioj<Tffp,0*2C
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1`8B,0*07
 !AIVDM,1,1,,B,137JlD51@0P9tdFGbCNGMhkn0@0g,0*51
 !AIVDM,1,1,,B,D028jJ03`N?b<`O6Dl<O6D0,2*35
 !AIVDM,1,1,,B,13FB78000009vH:Gc4sPb3h:0<2b,0*4D
 !AIVDM,1,1,,B,4028j;1vDB<;509cIDGdh@Q0083a,0*5E
 !AIVDM,1,1,,B,D028j;0flffp,0*40
 !AIVDM,1,1,,B,B3EprgP0=p2RUrUrr9J=cwSUoP06,0*2E
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1d1c,0*28
 !AIVDM,1,1,,B,4028jJ1vDB<;:09cH`Gdh8w020S:,0*6A
 !AIVDM,1,1,,A,D028j;2<Tffp,0*23
 !AIVDM,1,1,,A,13E`ukgP00P:ljhGgHCh0?vP20SF,0*51
 !AIVDM,1,1,,A,D028jJ1TPN?b<`O6EqHO6D0,2*08
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1W3h,0*11
 !AIVDM,1,1,,A,D028ioiMdffp,0*6E
 !AIVDM,1,1,,A,4028jJ1vDB<;D09cHVGdh8O02L2a,0*5F
 !AIVDM,1,1,,B,13FB78000009vHBGc4shb3hj08>N,0*79
 !AIVDM,1,1,,B,4028j;1vDB<;I09cINGdh=i008?G,0*47
 !AIVDM,1,1,,B,D028j;2<Tffp,0*20
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1PS?,0*22
 !AIVDM,1,1,,B,B3GPqr@00H2S@T5s9J0<kwg5oP06,0*73
 !AIVDM,1,1,,B,4028jJ1vDB<;N09cHTGdh6w020S:,0*24
 !AIVDM,1,1,,B,13F:b60P0009wLRGblu61?vv0<1w,0*41
 !AIVDM,1,1,,A,B3JI6UP00@2SKm5s9uwEswhUkP06,0*5C
 !AIVDM,1,1,,B,B3F5Up00002TBnUsG2OQ3wi1jEc:,0*6F
 !AIVDM,1,1,,A,D028j;1Mdffp,0*61
 !AIVDM,1,1,,A,4028jJ1vDB<;`09cHRGdh5O02L2a,0*72
 !AIVDM,1,1,,B,137JlD5000P9tdFGbCN7aPk@05Pd,0*7C
 !AIVDM,1,1,,A,13F:b60P0009wLPGblt6JwwF0<1w,0*43
 !AIVDM,1,1,,B,13FB78000009vHBGc4sPb3iH08IS,0*08
 !AIVDM,1,1,,B,4028j;1vDB<;e09cINGdh;1000S:,0*2C
 !AIVDM,1,1,,B,D028j;1Mdffp,0*62
 !AIVDM,1,1,,A,137JlD5000P9tdDGbCN7APkR0D1u,0*4E
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1h2Q,0*15
 !AIVDM,1,1,,B,4028jJ1vDB<;j09cHPGdh4?020S:,0*4E
 !AIVDM,1,1,,A,3913Q?E000P9t:@Gb85bu@Gb0D`b,0*7E
 !AIVDM,1,1,,A,4028j;1vDB<;o09cILGdh:A005Pd,0*0E
 !AIVDM,1,1,,A,D028j;0flffp,0*43
 !AIVDM,2,1,3,B,5913Q?H2Amj?M@P<001<DA85@400000000000016?000D4@l6BADhPkP0000,0*40
 !AIVDM,2,2,3,B,00000000000,2*24
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1W3h,0*11
 !AIVDM,2,1,4,B,58VCNp02:@q5TaAWL0058<PE800000000000001J;P9994B:0AiDp0PkP000,0*69
 !AIVDM,2,2,4,B,00000000000,2*23
 !AIVDM,1,1,,B,H3=2TThPTLPh4pB0HhTpN37D000,2*47
 !AIVDM,1,1,,B,D028jJ03`N?b<`O6Dl<O6D0,2*35
 !AIVDM,1,1,,B,13FB78000009vH@Gc4uhb3h:082f,0*09
 !AIVDM,1,1,,B,D028j;0flffp,0*40
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1`=J,0*09
 !AIVDM,1,1,,B,4028jJ1vDB<<:09cHTGdh1O02H6J,0*05
 !AIVDM,1,1,,B,B3EprgP0882ROV5rqdFAWwV5oP06,0*42
 !AIVDM,1,1,,B,H3=2TTlT>F34R4cq82lpnm4H0440,0*0B
 !AIVDM,1,1,,A,D028j;2<Tffp,0*23
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1PSP,0*4E
 !AIVDM,1,1,,A,4028jJ1vDB<<D09cH`Gdh0O02H<A,0*4C
 !AIVDM,1,1,,B,13FB78000009vH>Gc4vhb3hj05Ph,0*45
 !AIVDM,1,1,,B,D028j;2<Tffp,0*20
 !AIVDM,1,1,,B,38159nU00009uQ@GbWPUKPdn0Dg:,0*3A
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1pIC,0*64
 !AIVDM,1,1,,B,4028jJ1vDB<<N09cHhGdgw?02HB8,0*72
 !AIVDM,1,1,,A,D028j;1Mdffp,0*61
 !AIVDM,1,1,,A,13Evhn5P?w<tSF0l4Q@>4?wv1hO8,0*02
 !AIVDM,1,1,,A,4028jJ1vDB<<`09cHlGdgvO02HGw,0*60
 !AIVDM,1,1,,B,13FB78000009vH6Gc4v@b3iH05Ph,0*46
 !AIVDM,1,1,,B,4028j;1vDB<<e09cIBGdh:i00D3E,0*15
 !AIVDM,1,1,,B,D028j;1Mdffp,0*62
 !AIVDM,1,1,,B,H3GPqr@dtdu8v04000000000000,2*43
 !AIVDM,1,1,,B,13Evhn5P?w<tSF0l4Q@>4?wv1d1b,0*29
 !AIVDM,1,1,,B,4028jJ1vDB<<j09cHpGdguO02HMn,0*65

 */
