//
//  Date_PseudoIDTests.swift
//  
//
//  Created by John Cumming on 7/10/21.
//

import XCTest
@testable import Sorcery

class Date_PseudoUIDTests: XCTestCase {
    
    func testPseudoIdZero() {
        let start = date("00:00, 1 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "0000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdDay() {
        let start = date("00:00, 2 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "1000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdWeek() {
        let start = date("00:00, 8 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "7000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdTwoWeek() {
        let start = date("00:00, 15 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "14000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdBeforeDay() {
        let start = date("00:00, 31 Dec 2020")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "-1000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdBefore12Hours() {
        let start = date("12:00, 31 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "364HZZ")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdBefore1Aug() {
        let start = date("12:00, 1 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "334HZZ")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }
    
    func testPseudoId24HourMinus() {
        let start = date("23:59, 1 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "0ZZ2")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdDec24() {
        let start = date("00:00, 25 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "358000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }
    
    func testPseudoIdMar12() {
        let start = date("12:00, 12 Mar 2022")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "435HZZ")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdJan12019() {
        let start = date("00:00, 1 Jan 2019")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "-731000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }

    func testPseudoIdOneYear() {
        let start = date("00:00, 1 Sep 2022")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "608000")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertTrue(start.isNearlySame(pseudoDate))
    }
    
    // MARK: -
    
    func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.date(from: string)!
    }
    
}
