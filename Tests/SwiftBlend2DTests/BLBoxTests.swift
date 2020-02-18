import XCTest
import blend2d
import SwiftBlend2D

class BLBoxTests: XCTestCase {
    func testEmpty() {
        let empty = BLBox.empty

        XCTAssertEqual(empty.x0, 0)
        XCTAssertEqual(empty.y0, 0)
        XCTAssertEqual(empty.x1, 0)
        XCTAssertEqual(empty.y1, 0)
    }

    func testEquals() {
        XCTAssertEqual(BLBox(x0: 0, y0: 0, x1: 0, y1: 0), BLBox(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBox(x0: 1, y0: 0, x1: 0, y1: 0), BLBox(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBox(x0: 0, y0: 1, x1: 0, y1: 0), BLBox(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBox(x0: 0, y0: 0, x1: 1, y1: 0), BLBox(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBox(x0: 0, y0: 0, x1: 0, y1: 1), BLBox(x0: 0, y0: 0, x1: 0, y1: 0))
    }
    
    func testReset() {
        var box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)
        
        box.reset()
        
        XCTAssertEqual(box.x0, 0)
        XCTAssertEqual(box.y0, 0)
        XCTAssertEqual(box.x1, 0)
        XCTAssertEqual(box.y1, 0)
    }
    
    func testContains() {
        let box = BLBox(x0: 0, y0: 0, x1: 10, y1: 10)
        
        XCTAssert(box.contains(0, 0))
        XCTAssert(box.contains(5, 5))
        XCTAssertFalse(box.contains(10, 10))
        XCTAssertFalse(box.contains(-5, 5))
        XCTAssertFalse(box.contains(5, -5))
    }
    
    func testContainsPoint() {
        let box = BLBox(x0: 0, y0: 0, x1: 10, y1: 10)
        
        XCTAssert(box.contains(BLPoint(x: 0, y: 0)))
        XCTAssert(box.contains(BLPoint(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPoint(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPoint(x: 5, y: -5)))
    }
    
    func testContainsPointI() {
        let box = BLBox(x0: 0, y0: 0, x1: 10, y1: 10)
        
        XCTAssert(box.contains(BLPointI(x: 0, y: 0)))
        XCTAssert(box.contains(BLPointI(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPointI(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 5, y: -5)))
    }
    
    func testInitWithWidthAndHeight() {
        let box = BLBox(x: 5, y: 5, width: 10, height: 10)
        
        XCTAssertEqual(box.x0, 5)
        XCTAssertEqual(box.y0, 5)
        XCTAssertEqual(box.x1, 15)
        XCTAssertEqual(box.y1, 15)
    }
    
    func testQuadrants() {
        let box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)
        
        XCTAssertEqual(box.topLeft, BLPoint(x: 1, y: 2))
        XCTAssertEqual(box.topRight, BLPoint(x: 3, y: 2))
        XCTAssertEqual(box.bottomLeft, BLPoint(x: 1, y: 4))
        XCTAssertEqual(box.bottomRight, BLPoint(x: 3, y: 4))
    }
    
    func testWidth() {
        let box = BLBox(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.w, 5)
    }
    
    func testHeight() {
        let box = BLBox(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.h, 5)
    }

    func testAsRectangle() {
        let box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)

        XCTAssertEqual(box.asBLRect, BLRect(x: 1, y: 2, w: 2, h: 2))
    }
    
    func testCenter() {
        var box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)
        
        XCTAssertEqual(box.center, BLPoint(x: 2, y: 3))
        
        box.center = BLPoint(x: 5, y: 6)
        
        XCTAssertEqual(box, BLBox(x0: 4, y0: 5, x1: 6, y1: 7))
    }

    func testOffsetBy() {
        let box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)

        let offset = box.offsetBy(x: 10, y: 20)

        XCTAssertEqual(offset, BLBox(x0: 11, y0: 22, x1: 13, y1: 24))
    }

    func testInset() {
        let box = BLBox(x0: 0, y0: 0, x1: 10, y1: 10)
        let result = box.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.x0, 1)
        XCTAssertEqual(result.y0, 1)
        XCTAssertEqual(result.x1, 9)
        XCTAssertEqual(result.y1, 9)
    }

    func testResized() {
        let box = BLBox(x0: 10, y0: 10, x1: 30, y1: 30)
        let result = box.resized(width: 10, height: 10)

        XCTAssertEqual(result.x0, 10)
        XCTAssertEqual(result.y0, 10)
        XCTAssertEqual(result.x1, 20)
        XCTAssertEqual(result.y1, 20)
    }

    func testInitBoundsForPoints() {
        let box = BLBox(boundsForPoints: [
            BLPoint(x: -5, y: 5),
            BLPoint(x: 5, y: -5),
            BLPoint(x: 7, y: -5)
        ])

        XCTAssertEqual(box.x0, -5)
        XCTAssertEqual(box.y0, -5)
        XCTAssertEqual(box.x1, 7)
        XCTAssertEqual(box.y1, 5)
    }

    func testInitBoundsForPointsWithSinglePoint() {
        let box = BLBox(boundsForPoints: [
            BLPoint(x: 5, y: 5),
        ])

        XCTAssertEqual(box.x0, 5)
        XCTAssertEqual(box.y0, 5)
        XCTAssertEqual(box.x1, 5)
        XCTAssertEqual(box.y1, 5)
    }

    func testInitBoundsForPointsEmpty() {
        let box = BLBox(boundsForPoints: [])

        XCTAssertEqual(box, BLBox.empty)
    }
    
    func testInitWithBoxI() {
        let box = BLBox(BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4))
        
        XCTAssertEqual(box.x0, 1)
        XCTAssertEqual(box.y0, 2)
        XCTAssertEqual(box.x1, 3)
        XCTAssertEqual(box.y1, 4)
    }
}
