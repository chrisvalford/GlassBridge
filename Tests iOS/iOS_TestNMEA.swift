//
//  iOS_TestNMEA.swift
//  Tests iOS
//
//  Created by Christopher Alford on 30/4/22.
//

import XCTest

class iOS_TestNMEA: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChecksumCreate() throws {
        let sentence = "$GPGLL,6004.4083,N,01940.5157,E,094140,A,D*4D"
        let nmea = try NMEA0813Base(rawData: sentence)
        let checksum = nmea.calculateChecksum(from: sentence)
        XCTAssert(checksum == 0x4D)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
