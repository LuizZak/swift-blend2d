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

    func testInset() {
        let rect = BLRect(x: 0, y: 0, w: 10, h: 10)
        let result = rect.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 1)
        XCTAssertEqual(result.w, 8)
        XCTAssertEqual(result.h, 8)
    }

    func testQuadrants() {
        let rect = BLRect(x: 2, y: 2, w: 4, h: 4)

        XCTAssertEqual(rect.topLeft, BLPoint(x: 2, y: 2))
        XCTAssertEqual(rect.topRight, BLPoint(x: 6, y: 2))
        XCTAssertEqual(rect.bottomLeft, BLPoint(x: 2, y: 6))
        XCTAssertEqual(rect.bottomRight, BLPoint(x: 6, y: 6))
    }
}
