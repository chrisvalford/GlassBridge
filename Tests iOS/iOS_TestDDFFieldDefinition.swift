//
//  iOS_TestDDFFieldDefinition.swift
//  Tests iOS
//
//  Created by Christopher Alford on 27/4/22.
//

import XCTest

class iOS_TestDDFFieldDefinition: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Given a string like "(A,3(B,C),D),X,Y)" return "A,3(B,C),D".
    // Give a string like "3A,2C" return "3A".
    func testDDFFieldDefinitionExtractSubstring() throws {
        let ddf = DDFFieldDefinition()
        let source = "(A,3(B,C),D),X,Y)"
        let r1 = ddf.extractSubstring(pszSrc: source.byteArray)
        XCTAssert(r1.string == "A,3(B,C),D")
    }
    
    //  For: (A(2),I(10),3A,A(3),4R,2A)
    //  Expect: A(2),I(10),A,A,A,A(3),R,R,R,R,A,A
    func testDDFFieldDefinitionExpandFormat() throws {
        let ddf = DDFFieldDefinition(fixedWidth: 0)
        let source = "(A(2),I(10),3A,A(3),4R,2A)"
        let r1 = ddf.expandFormat(pszSrc: source.byteArray)
        XCTAssert(r1.string == "A(2),I(10),A,A,A,A(3),R,R,R,R,A,A")
    }
    
    func testDDFFieldDefinitionFetchVariable() throws {
        let pachFieldArea = "0100;&   ISO/IEC 8211 Record Identifier\0x1f\0x1f(I(5))\0x1e1600;&   Catalogue Directory Field\0x1fRCNM!RCID!FILE!LFIL!VOLM!IMPL!SLAT!WLON!NLAT!ELON!CRCS!COMT\0x1f(A(2),I(10),3A,A(3),4R,2A)\0x1e".byteArray
        let iFDOffset = 9
        let nFieldEntrySize = 48
        var nCharsConsumed: Int = 0
        let ddf = DDFFieldDefinition()
        let result = ddf.fetchVariable(pszRecord: Array(pachFieldArea[iFDOffset...]),
                                       nMaxChars: nFieldEntrySize - iFDOffset,
                                       nDelimChar1: unitTerminator,
                                       nDelimChar2: fieldTerminator,
                                       pnConsumedChars: &nCharsConsumed)
        XCTAssert(!result.isEmpty)
        let str = String(bytes: result, encoding: .utf8)
        XCTAssert(str == "ISO/IEC 8211 Record Identifier\0x1f\0x1f")
    }

    
    
    func testDDFFieldDefinitionApplyFormats() throws {
        let formatControls = "(A(2),I(10),3A,A(3),4R,2A)".byteArray
        var ddf = DDFFieldDefinition()
        let subfieldDefinition = DDFSubfieldDefinition(name: "RCNM",
                                                       isVariable: true,
                                                       formatWidth: 0,
                                                       formatDelimeter: unitTerminator,
                                                       eBinaryFormat: DDFBinaryFormat.NotBinary,
                                                       eType: DDFDataType.DDFString,
                                                       formatString: "".byteArray)
        for _ in 0..<12 {
            ddf.subfieldDefinitions.append(subfieldDefinition)
        }
        let r1 = ddf.applyFormats(formatControls: formatControls)
        XCTAssert(r1 == true)
    }
    
    func testDDFFieldDefinitionFindSubfieldDefinition() throws {
        var ddf = DDFFieldDefinition()
        for i in 0..<12 {
            let subfieldDefinition = DDFSubfieldDefinition(name: "RCNM\(i)",
                                                           isVariable: true,
                                                           formatWidth: 0,
                                                           formatDelimeter: unitTerminator,
                                                           eBinaryFormat: DDFBinaryFormat.NotBinary,
                                                           eType: DDFDataType.DDFString,
                                                           formatString: "".byteArray)
            ddf.subfieldDefinitions.append(subfieldDefinition)
        }
        let r1 = ddf.findSubfieldDefn(named: "RCNM3")
        XCTAssert(r1 != nil)
    }

}
