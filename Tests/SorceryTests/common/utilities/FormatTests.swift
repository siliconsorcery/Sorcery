//
//  FormatTests.swift
//  Sorcery
//
//  Created by John Cumming on 6/17/21.
//

import XCTest
@testable import Sorcery

class FormatTests: XCTestCase {
    
    func testBasic() {
        let start = Date()
        XCTAssertNotNil(Format.dates(start))
    }
    
    func testBaseline() {
        let start = date("12:00, 1 Jan 2000")
        XCTAssertEqual(Format.dates(start), "Sat Jan 1 2000 12:00 PM")
    }

    func testOneHourTime() {
        let start = date("13:00, 1 Jan 2000")
        let relativeTo = date("12:00, 1 Jan 2000")
        XCTAssertEqual(Format.dates(start, relativeTo: relativeTo), "Today 1:00 PM")
    }

    func testOneHour() {
        let start = date("13:00, 1 Jan 2000")
        let isAllDay = true
        let relativeTo = date("12:00, 1 Jan 2000")
        XCTAssertEqual(Format.dates(start, isAllDay: isAllDay, relativeTo: relativeTo), "Today")
    }

    
    // MARK: -
    
    func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.date(from: string)!
    }
}
