//
//  iOS_TestDDFModule.swift
//  Tests iOS
//
//  Created by Christopher Alford on 27/4/22.
//

import XCTest

class iOS_TestDDFModule: XCTestCase {
    
    var module: DDFModule?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "CATALOG", ofType: "031") else {
            throw Exception.IOException
        }
        module = DDFModule(url: URL(fileURLWithPath: path))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if module != nil {
            module?.close()
        }
    }

    func testExample() throws {
        if let fdCount = module?.fieldDefinitions.count {
            XCTAssert(fdCount > 0)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
