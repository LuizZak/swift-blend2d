import XCTest
import blend2d
@testable import SwiftBlend2D

class BLRectTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRect(x: 0, y: 1, w: 2, h: 3),
                       BLRect(x: 0, y: 1, w: 2, h: 3))
        
        XCTAssertNotEqual(BLRect(x: 9, y: 1, w: 2, h: 3),
                          BLRect(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRect(x: 0, y: 9, w: 2, h: 3),
                          BLRect(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRect(x: 0, y: 1, w: 9, h: 3),
                          BLRect(x: 0, y: 1, w: 2, h: 3))
        XCTAssertNotEqual(BLRect(x: 0, y: 1, w: 2, h: 9),
                          BLRect(x: 0, y: 1, w: 2, h: 3))
    }
}
