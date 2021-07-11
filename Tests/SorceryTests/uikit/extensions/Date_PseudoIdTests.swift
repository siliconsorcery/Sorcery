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
        XCTAssertEqual(pseudoId, "0:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdDay() {
        let start = date("00:00, 2 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "1:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdWeek() {
        let start = date("00:00, 8 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "7:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdTwoWeek() {
        let start = date("00:00, 15 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "14:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdBeforeDay() {
        let start = date("00:00, 31 Dec 2020")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "-1:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdBefore12Hours() {
        let start = date("12:00, 31 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "364:5K0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdBefore1Aug() {
        let start = date("12:00, 1 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "334:5K0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }
    
    func testPseudoId24HourMinus() {
        let start = date("23:59, 1 Jan 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "0:B3Q")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdDec24() {
        let start = date("00:0, 25 Dec 2021")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "358:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }
    
    func testPseudoIdMar12() {
        let start = date("12:00, 12 Mar 2022")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "435:5K0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdJan12019() {
        let start = date("00:00, 1 Jan 2019")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "-731:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }

    func testPseudoIdOneYear() {
        let start = date("00:00, 1 Sep 2022")
        let pseudoId = start.pseudoId()
        XCTAssertEqual(pseudoId, "608:0")
        let pseudoDate = Date.pseudoId(from: pseudoId)
        XCTAssertEqual(start, pseudoDate)
    }
    
    // MARK: -
    
    func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.date(from: string)!
    }
    
}
