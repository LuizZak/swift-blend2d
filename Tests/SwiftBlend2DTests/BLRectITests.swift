import XCTest
import blend2d
@testable import SwiftBlend2D

class BLRectITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRectI(x: 0, y: 1, w: 2, h: 3),
                       BLRectI(x: 0, y: 1, w: 2, h: 3))
        
        XCTAssertNotEqual(BLRectI(x: 9, y: 1, w: 2, h: 3),
                          BLRectI(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRectI(x: 0, y: 9, w: 2, h: 3),
                          BLRectI(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRectI(x: 0, y: 1, w: 9, h: 3),
                          BLRectI(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRectI(x: 0, y: 1, w: 2, h: 9),
                          BLRectI(x: 0, y: 1, w: 2, h: 3))
    }
}
