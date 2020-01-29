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

    func testSides() {
        let rect = BLRectI(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.top, 2)
        XCTAssertEqual(rect.right, 4)
        XCTAssertEqual(rect.left, 1)
        XCTAssertEqual(rect.bottom, 6)
    }

    func testSize() {
        var rect = BLRectI(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.size, BLSizeI(w: 3, h: 4))

        rect.size = BLSizeI(w: 5, h: 6)

        XCTAssertEqual(rect.size, BLSizeI(w: 5, h: 6))
    }

    func testCenter() {
        var rect = BLRectI(x: 1, y: 2, w: 3, h: 4)

        XCTAssertEqual(rect.center, BLPointI(x: 2, y: 4))

        rect.center = BLPointI(x: 5, y: 6)

        XCTAssertEqual(rect, BLRectI(x: 4, y: 4, w: 3, h: 4))
    }

    func testContains() {
        let box = BLRectI(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(0, 0))
        XCTAssert(box.contains(5, 5))
        XCTAssertFalse(box.contains(10, 10))
        XCTAssertFalse(box.contains(-5, 5))
        XCTAssertFalse(box.contains(5, -5))
    }

    func testContainsPoint() {
        let box = BLRectI(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(BLPoint(x: 0, y: 0)))
        XCTAssert(box.contains(BLPoint(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPoint(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 5, y: -5)))
    }

    func testContainsPointI() {
        let box = BLRectI(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(BLPointI(x: 0, y: 0)))
        XCTAssert(box.contains(BLPointI(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPointI(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 5, y: -5)))
    }

    func testResized() {
        let rect = BLRectI(x: 10, y: 10, w: 30, h: 30)
        let result = rect.resized(width: 10, height: 10)

        XCTAssertEqual(result.x, 10)
        XCTAssertEqual(result.y, 10)
        XCTAssertEqual(result.w, 10)
        XCTAssertEqual(result.h, 10)
    }

    func testInitWithRoundedRect() {
        let rect = BLRectI(rounding: BLRect(x: 10.4, y: 10.6, w: 20.4, h: 20.6))

        XCTAssertEqual(rect.x, 10)
        XCTAssertEqual(rect.y, 11)
        XCTAssertEqual(rect.w, 20)
        XCTAssertEqual(rect.h, 21)
    }

    func testInitWithLocationAndSize() {
        let rect = BLRectI(location: BLPointI(x: 1, y: 2), size: BLSizeI(w: 3, h: 4))

        XCTAssertEqual(rect.x, 1)
        XCTAssertEqual(rect.y, 2)
        XCTAssertEqual(rect.w, 3)
        XCTAssertEqual(rect.h, 4)
    }

    func testContainsRect() {
        let rect = BLRectI(x: 0, y: 0, w: 20, h: 20)

        XCTAssert(rect.contains(rect))
        XCTAssert(rect.contains(BLRectI(x: 10, y: 10, w: 5, h: 5)))
        XCTAssertFalse(rect.contains(BLRectI(x: 10, y: 10, w: 15, h: 15)))
        XCTAssertFalse(rect.contains(BLRectI(x: 30, y: 30, w: 15, h: 15)))
    }

    func testIntersects() {
        let rect1 = BLRectI(x: 0, y: 0, w: 20, h: 20)
        let rect2 = BLRectI(x: 10, y: 10, w: 20, h: 20)
        let rect3 = BLRectI(x: 30, y: 0, w: 20, h: 20)

        XCTAssert(rect1.intersects(rect2))
        XCTAssertFalse(rect1.intersects(rect3))
        XCTAssert(rect2.intersects(rect3))
    }
    
    func testLocation() {
        var rect = BLRectI(x: 0, y: 0, w: 10, h: 15)
        
        rect.location = BLPointI(x: 20, y: 25)
        
        XCTAssertEqual(rect.x, 20)
        XCTAssertEqual(rect.y, 25)
        XCTAssertEqual(rect.w, 10)
        XCTAssertEqual(rect.h, 15)
    }
}
