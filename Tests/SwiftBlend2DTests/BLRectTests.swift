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
    
    func testHashable() {
        XCTAssertEqual(BLRect(x: 0, y: 1, w: 2, h: 3).hashValue,
                       BLRect(x: 0, y: 1, w: 2, h: 3).hashValue)
        
        XCTAssertNotEqual(BLRect(x: 9, y: 1, w: 2, h: 3).hashValue,
                          BLRect(x: 0, y: 1, w: 2, h: 3).hashValue)
        XCTAssertNotEqual(BLRect(x: 0, y: 9, w: 2, h: 3).hashValue,
                          BLRect(x: 0, y: 1, w: 2, h: 3).hashValue)
        XCTAssertNotEqual(BLRect(x: 0, y: 1, w: 9, h: 3).hashValue,
                          BLRect(x: 0, y: 1, w: 2, h: 3).hashValue)
        XCTAssertNotEqual(BLRect(x: 0, y: 1, w: 2, h: 9).hashValue,
                          BLRect(x: 0, y: 1, w: 2, h: 3).hashValue)
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

    func testContains() {
        let box = BLRect(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(0, 0))
        XCTAssert(box.contains(5, 5))
        XCTAssertFalse(box.contains(10, 10))
        XCTAssertFalse(box.contains(-5, 5))
        XCTAssertFalse(box.contains(5, -5))
    }

    func testContainsPoint() {
        let box = BLRect(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(BLPoint(x: 0, y: 0)))
        XCTAssert(box.contains(BLPoint(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPoint(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 5, y: -5)))
    }

    func testContainsPointI() {
        let box = BLRect(x: 0, y: 0, w: 10, h: 10)

        XCTAssert(box.contains(BLPointI(x: 0, y: 0)))
        XCTAssert(box.contains(BLPointI(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPointI(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 5, y: -5)))
    }

    func testResized() {
        let rect = BLRect(x: 10, y: 10, w: 30, h: 30)
        let result = rect.resized(width: 10, height: 10)

        XCTAssertEqual(result.x, 10)
        XCTAssertEqual(result.y, 10)
        XCTAssertEqual(result.w, 10)
        XCTAssertEqual(result.h, 10)
    }

    func testInitWithLocationAndSize() {
        let rect = BLRect(location: BLPoint(x: 1, y: 2), size: BLSize(w: 3, h: 4))

        XCTAssertEqual(rect.x, 1)
        XCTAssertEqual(rect.y, 2)
        XCTAssertEqual(rect.w, 3)
        XCTAssertEqual(rect.h, 4)
    }

    func testContainsRect() {
        let rect = BLRect(x: 0, y: 0, w: 20, h: 20)

        XCTAssert(rect.contains(rect))
        XCTAssert(rect.contains(BLRect(x: 10, y: 10, w: 5, h: 5)))
        XCTAssertFalse(rect.contains(BLRect(x: 10, y: 10, w: 15, h: 15)))
        XCTAssertFalse(rect.contains(BLRect(x: 30, y: 30, w: 15, h: 15)))
    }

    func testIntersects() {
        let rect1 = BLRect(x: 0, y: 0, w: 20, h: 20)
        let rect2 = BLRect(x: 10, y: 10, w: 20, h: 20)
        let rect3 = BLRect(x: 30, y: 0, w: 20, h: 20)

        XCTAssert(rect1.intersects(rect2))
        XCTAssertFalse(rect1.intersects(rect3))
        XCTAssert(rect2.intersects(rect3))
    }
    
    func testLocation() {
        var rect = BLRect(x: 0, y: 0, w: 10, h: 15)
        
        rect.location = BLPoint(x: 20, y: 25)
        
        XCTAssertEqual(rect.x, 20)
        XCTAssertEqual(rect.y, 25)
        XCTAssertEqual(rect.w, 10)
        XCTAssertEqual(rect.h, 15)
    }

    func testAsBox() {
        let rect = BLRect(x: 1, y: 2, w: 3, h: 5)
        let box = rect.asBLBox

        XCTAssertEqual(box.x0, 1)
        XCTAssertEqual(box.y0, 2)
        XCTAssertEqual(box.x1, 4)
        XCTAssertEqual(box.y1, 7)
    }
    
    func testOffsetBy() {
        let rect = BLRect(x: 1, y: 2, w: 3, h: 5)
        let result = rect.offsetBy(x: 2, y: 3)
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 5)
        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 5)
    }

    func testInitWithBLRectI() {
        let rect = BLRectI(x: 1, y: 2, w: 3, h: 5)
        let result = BLRect(rect)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 2)
        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 5)
    }

    func testInitWithBLBox() {
        let box = BLBox(x: 1, y: 2, w: 3, h: 5)
        let result = BLRect(box: box)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 2)
        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 5)
    }

    func testInitWithBLBoxI() {
        let boxI = BLBoxI(x: 1, y: 2, w: 3, h: 5)
        let result = BLRect(boxI: boxI)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 2)
        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 5)
    }
    
    func testDescription() {
        let rect = BLRect(x: 0, y: 1, w: 2, h: 3)
        
        XCTAssertEqual(rect.description,
                       "BLRect(x: 0.0, y: 1.0, w: 2.0, h: 3.0)")
    }
}
