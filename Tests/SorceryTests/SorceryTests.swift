import XCTest
@testable import Sorcery

final class SorceryTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Sorcery().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
