//
//  Date_FormattingTests.swift
//  Sorcery
//
//  Created by John Cumming on 6/12/21.
//  Copyright © 2021 Silicon Sorcery. All rights reserved.
//

import XCTest

class Date_FormattingAgoTests: XCTestCase {
    
    func testJustnow() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "Just now")
    }

    func testOneMinuteAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:59, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 minute ago")
    }

    func test30MinutesAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:30, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "30 minutes ago")
    }

    func test59MinutesAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:01, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "59 minutes ago")
    }
    
    func testOneHourAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:00, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 hour ago")
    }

    func test89MinutesAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("10:31, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 hour ago")
    }
    
    func test90MinutesAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("10:30, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 hour ago")
    }
    
    func test119MinutesAgo() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("10:01, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "2 hours ago")
    }

    func test11HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("13:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "11 hours ago")
    }

    func test12HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("12:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "12 hours ago")
    }

    func test13HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("11:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "13 hours ago")
    }

    func test22HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("02:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "22 hours ago")
    }

    func test23HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("01:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "23 hours ago")
    }

    func test24HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("00:00, 9 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 day ago")
    }

    func test25HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("23:00, 8 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 day ago")
    }

    func test36HoursAgo() {
        let start = date("00:00, 10 Jan 2000")
        let date = date("12:00, 8 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "2 days ago")
    }

    func test6DaysAgo() {
        let start = date("12:00, 21 Jan 2000")
        let date = date("12:00, 15 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "6 days ago")
    }

    func test6Days12HoursAgo() {
        let start = date("12:00, 21 Jan 2000")
        let date = date("00:00, 14 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 week ago")
    }
    
    func test7DaysAgo() {
        let start = date("00:00, 21 Jan 2000")
        let date = date("00:00, 14 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 week ago")
    }

    func test14DaysAgo() {
        let start = date("00:00, 31 Jan 2000")
        let date = date("00:00, 17 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "2 weeks ago")
    }

    func test28DaysAgo() {
        let start = date("00:00, 31 Jan 2000")
        let date = date("00:00, 3 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "4 weeks ago")
    }

    func test1MonthAgo() {
        let start = date("00:00, 1 Dec 2000")
        let date = date("00:00, 1 Nov 2000")
        XCTAssertEqual(date.relative(to: start), "1 month ago")
    }

    func test11MonthAgo() {
        let start = date("00:00, 1 Dec 2000")
        let date = date("00:00, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "11 months ago")
    }

    func test11Month15DaysAgo() {
        let start = date("00:00, 16 Dec 2000")
        let date = date("00:00, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "1 year ago")
    }

    func test2yearsAgo() {
        let start = date("00:00, 1 Jan 2000")
        let date = date("00:00, 1 Jan 1998")
        XCTAssertEqual(date.relative(to: start), "2 years ago")
    }

    
    // MARK: -
    
    func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.date(from: string)!
    }
}

class Date_FormattingInTests: XCTestCase {

    func testIn1Year() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 1 Jan 2001")
        XCTAssertEqual(date.relative(to: start), "in 1 year")
    }
    
    func testIn11Months() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 1 Dec 2000")
        XCTAssertEqual(date.relative(to: start), "in 11 months")
    }
    
    func testIn5Weeks() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 5 Feb 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 month")
    }
    
    func testIn4Weeks() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 29 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 4 weeks")
    }
    
    func testIn2Weeks() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 15 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 2 weeks")
    }

    func testIn2WeeksLess1Hour() {
        let start = date("00:00, 1 Jan 2000")
        let date = date("23:00, 13 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 2 weeks")
    }
    
    func testIn7Days() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 8 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 week")
    }

    func testIn6Days12Hours() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("00:00, 8 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 week")
    }
    
    func testIn6Days() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 7 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 6 days")
    }
    
    func testIn24Hours() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:00, 2 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 day")
    }

    func testIn24less1minuteHours() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:59, 2 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 day")
    }

    func testIn24less30minutesHours() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("11:30, 2 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 day")
    }
    
    func testIn16Hours() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("04:00, 2 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 16 hours")
    }
    
    func testIn90Minutes() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("13:30, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 2 hours")
    }

    func testIn89Minutes() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("13:29, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 hour")
    }
    
    func testIn61Minutes() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("13:01, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 hour")
    }
    
    func testIn60Minutes() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("13:00, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 hour")
    }
    
    func testIn2Minutes() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:02, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 2 minutes")
    }
    
    func testIn1Minute() {
        let start = date("12:00, 1 Jan 2000")
        let date = date("12:01, 1 Jan 2000")
        XCTAssertEqual(date.relative(to: start), "in 1 minute")
    }

    // MARK: -
    
    func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.date(from: string)!
    }
}
