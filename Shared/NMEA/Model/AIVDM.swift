//
//  AIVDM.swift
//  GlassBridge
//
//  Created by Christopher Alford on 04.01.21.
//  Copyright © 2021 marine+digital. All rights reserved.
//

import Foundation

// !AIVDM,1,1,,A,133m@ogP00PD;88MD5MTDww@2D7k,0*46
//!AIVDM,1,1,,B,177KQJ5000G?tO`K>RA1wUbN0TKH,0*5C
class AIVDM {
    var binaryString: String
    var messageType: String
    var repeatIndicator: String
    var mmsi: Int
    var navigationStatus: NavigationStatus
    var rateOfTurn: RateOfTurn
    var speedOverGround: SOG

    /*
     The position accuracy flag indicates the accuracy of the fix. A value of 1 indicates a DGPS-quality fix with an accuracy of < 10ms. 0, the default, indicates an unaugmented GNSS fix with accuracy > 10m.
     */
    var positionAccuracy: Bool

    var latitude: Latitude
    var longitude: Longitude
    var courseOverGround: Double
    var trueHeading: Int
    var timeStamp: Int
    var maneuvertIndicator: String?
    var spare: String?
    var raimFlag: Bool
    var radioStatus: String?

    init(_ binaryString: String) {
        self.binaryString = binaryString

        if binaryString.count == 168 {
            print("Message length OK")
            //AIS encodes messages using a 6-bits ASCII mechanism and 168 divided by 6 is 28.
            //There are 28 characters passed in the message segment
        }

        messageType = self.binaryString[0..<5]
        repeatIndicator = self.binaryString[6..<7]

        let mmsiBytes = self.binaryString[8..<37]
        mmsi = Int(mmsiBytes, radix: 2) ?? 0

        let navigationStatusBits = self.binaryString[38..<41]
        if let navigationStatusInt = Int(navigationStatusBits, radix: 2) {
            navigationStatus = NavigationStatus(rawValue: navigationStatusInt)!
        } else {
            navigationStatus = NavigationStatus.notDefined
        }

        let rotBits = self.binaryString[42..<49]
        if let rotInt = Int(rotBits, radix: 2) {
            rateOfTurn = RateOfTurn(rawValue: ~rotInt + 1)
        } else {
            rateOfTurn = RateOfTurn.noTurnData
        }

        let sogBits = self.binaryString[50..<59]
        if let sogInt = Int(sogBits, radix: 2) {
            speedOverGround = SOG(sogInt)
        } else {
            speedOverGround = SOG(1023)
        }

        positionAccuracy = self.binaryString[60] == "1" ? true : false

        let longitudeBits = self.binaryString[61..<88]
        let lonInt = Int(longitudeBits, radix: 2) ?? 0
        let lonDouble = Double(lonInt) / 10000
        self.longitude = Longitude(lonDouble, mode: "big")

        let latitudeBits = self.binaryString[89..<115]
        let latInt = Int(latitudeBits, radix: 2) ?? 0
        self.latitude = Latitude(Double(latInt) / 10000, reference: .long360)

        let courseOverGroundBits = self.binaryString[116..<127]
        if let iCOG = Int(courseOverGroundBits, radix: 2) {
            courseOverGround = Double(iCOG) / 10
        } else {
            courseOverGround = 0
        }

        let trueHeadingBits = self.binaryString[128..<136]
        trueHeading = Int(trueHeadingBits, radix: 2) ?? 0

        let timestampBits = self.binaryString[137..<142]
        timeStamp = Int(timestampBits, radix: 2) ?? 0
        maneuvertIndicator = self.binaryString[143..<144]
        spare = self.binaryString[145..<147]
        raimFlag = self.binaryString[148] == "1" ? true : false
        radioStatus = self.binaryString[149..<167] //String(self.binaryString.dropFirst(19))

    }

    func ddToString(_ dd: Double) -> String {
        let degrees = Int(dd / 60)
        let remainder = dd.truncatingRemainder(dividingBy: 60)
        return String(format: "%d° %.4f'", degrees, remainder)
    }
}

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
