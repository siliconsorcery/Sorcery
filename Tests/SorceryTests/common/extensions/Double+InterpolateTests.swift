//
//  File.swift
//  
//
//  Created by John Cumming on 6/12/21.
//

import XCTest

class DoubleInterpolateTests: XCTestCase {
    
    func testHalf() {
        XCTAssertEqual(
            0.5.interpolate(to: 1.0, in: 0.5)
            ,0.75
            , accuracy: 0.0001
        )
    }

    func testZero() {
        XCTAssertEqual(
            0.5.interpolate(to: 10.0, in: 0.0)
            ,0.5
            , accuracy: 0.0001
        )
    }

    func testFull() {
        XCTAssertEqual(
            0.5.interpolate(to: 10.0, in: 1.0)
            ,10.0
            , accuracy: 0.0001
        )
    }
    
}
