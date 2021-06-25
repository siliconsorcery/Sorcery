//
//  TimeInterval_FormattedTests.swift
//  Sorcery
//
//  Created by John Cumming on 6/12/21.
//  Copyright © 2018 Silicon Sorcery. All rights reserved.
//

import XCTest
@testable import Sorcery

class TimeInterval_FormattedTests: XCTestCase {

    func test30Seconds() {
        XCTAssertEqual(TimeInterval(30.0).formatted(),"0.50 mins")
    }
    
    func testOneMinutes() {
        XCTAssertEqual(TimeInterval(60.0).formatted(),"1.00 min")
    }
    
    func testTwoMinutes() {
        XCTAssertEqual(TimeInterval(120.0).formatted(),"2.00 mins")
    }
    
    func testTwoMinutesAgo() {
        XCTAssertEqual(TimeInterval(-120.0).formatted(),"2.00 mins ago")
    }
    
    func testOneHour() {
        XCTAssertEqual(TimeInterval(60 * 60).formatted(),"1.00 hour")
    }

    func testOneDay() {
        XCTAssertEqual(TimeInterval(24 * 60 * 60).formatted(),"24.00 hours")
    }

    func testOneAndAHalfDays() {
        XCTAssertEqual(TimeInterval(36 * 60 * 60).formatted(),"1.50 days")
    }

    func testOneWeek() {
        XCTAssertEqual(TimeInterval(7 * 24 * 60 * 60).formatted(),"7.00 days")
    }

    func testTwoWeeks() {
        XCTAssertEqual(TimeInterval(2 * 7 * 24 * 60 * 60).formatted(),"2.00 weeks")
    }

    func testOneYear() {
        XCTAssertEqual(TimeInterval(52 * 7 * 24 * 60 * 60).formatted(),"1.00 years")
    }
}
