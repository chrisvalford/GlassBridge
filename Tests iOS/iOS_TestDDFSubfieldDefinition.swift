//
//  iOS_TestDDFSubfield.swift
//  Tests iOS
//
//  Created by Christopher Alford on 27/4/22.
//

import XCTest

class iOS_TestDDFSubfieldDefinition: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDDFSubfieldDefinitionSetFormat() throws {
        var ddf = DDFSubfieldDefinition(name: "Sample")
        let source = "A(2)"
        let r1 = ddf.setFormat(format: source.byteArray)
        XCTAssert(ddf.eType == .DDFString)
        XCTAssert(r1 == true)
    }

    func testDDFSubfieldDefinitionBuildSubfields() throws {
        var ddf = DDFFieldDefinition(fixedWidth: 0, hasRepeatingSubfields: false)
        let pszSublist = "RCNM!RCID!FILE!LFIL!VOLM!IMPL!SLAT!WLON!NLAT!ELON!CRCS!COMT"
        let r1 = ddf.buildSubfields(sublist: pszSublist)
        XCTAssert(r1 == true)
        XCTAssert(ddf.subfieldDefinitions.count == 12)
        let subfield = try ddf.getSubfield(i: 6)
        XCTAssert(subfield.name == "SLAT")
    }
}
