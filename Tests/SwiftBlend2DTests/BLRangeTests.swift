import XCTest
import blend2d
import SwiftBlend2D

class BLRangeTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRange(start: 1, end: 2), BLRange(start: 1, end: 2))
        
        XCTAssertNotEqual(BLRange(start: 9, end: 2), BLRange(start: 1, end: 2))
        XCTAssertNotEqual(BLRange(start: 1, end: 9), BLRange(start: 1, end: 2))
    }

    func testEverything() {
        XCTAssertEqual(BLRange.everything, BLRange(start: 0, end: .max))
    }
}
