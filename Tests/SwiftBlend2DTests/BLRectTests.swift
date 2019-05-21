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
        let rect = BLRect(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.topLeft, BLPoint(x: 1, y: 2))
        XCTAssertEqual(rect.topRight, BLPoint(x: 4, y: 2))
        XCTAssertEqual(rect.bottomLeft, BLPoint(x: 1, y: 6))
        XCTAssertEqual(rect.bottomRight, BLPoint(x: 4, y: 6))
    }

    func testSides() {
        let rect = BLRect(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.top, 2)
        XCTAssertEqual(rect.right, 4)
        XCTAssertEqual(rect.left, 1)
        XCTAssertEqual(rect.bottom, 6)
    }

    func testSize() {
        var rect = BLRect(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.size, BLSize(w: 3, h: 4))

        rect.size = BLSize(w: 5, h: 6)

        XCTAssertEqual(rect.size, BLSize(w: 5, h: 6))
    }

    func testCenter() {
        var rect = BLRect(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.center, BLPoint(x: 2.5, y: 4))

        rect.center = BLPoint(x: 5, y: 6)

        XCTAssertEqual(rect, BLRect(x: 3.5, y: 4, w: 3, h: 4))
    }
}
