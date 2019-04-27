import XCTest
import blend2d
import SwiftBlend2D

class BLRgba128Tests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRgba128(r: 1, g: 2, b: 3, a: 4),
                       BLRgba128(r: 1, g: 2, b: 3, a: 4))
        
        XCTAssertNotEqual(BLRgba128(r: 9, g: 2, b: 3, a: 4),
                          BLRgba128(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba128(r: 1, g: 9, b: 3, a: 4),
                          BLRgba128(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba128(r: 1, g: 2, b: 9, a: 4),
                          BLRgba128(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba128(r: 1, g: 2, b: 3, a: 9),
                          BLRgba128(r: 1, g: 2, b: 3, a: 4))
    }
}
