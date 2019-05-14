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

    func testInset() {
        let rect = BLRectI(x: 0, y: 0, w: 10, h: 10)
        let result = rect.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 1)
        XCTAssertEqual(result.w, 8)
        XCTAssertEqual(result.h, 8)
    }

    func testQuadrants() {
        let rect = BLRectI(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.topLeft, BLPointI(x: 1, y: 2))
        XCTAssertEqual(rect.topRight, BLPointI(x: 4, y: 2))
        XCTAssertEqual(rect.bottomLeft, BLPointI(x: 1, y: 6))
        XCTAssertEqual(rect.bottomRight, BLPointI(x: 4, y: 6))
    }

    func testSize() {
        var rect = BLRectI(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.size, BLSizeI(w: 3, h: 4))

        rect.size = BLSizeI(w: 5, h: 6)

        XCTAssertEqual(rect.size, BLSizeI(w: 5, h: 6))
    }
}
