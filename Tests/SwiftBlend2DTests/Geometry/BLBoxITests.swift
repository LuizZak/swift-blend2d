import XCTest
import blend2d
import SwiftBlend2D

class BLBoxITests: XCTestCase {
    func testEmpty() {
        let empty = BLBoxI.empty

        XCTAssertEqual(empty.x0, 0)
        XCTAssertEqual(empty.y0, 0)
        XCTAssertEqual(empty.x1, 0)
        XCTAssertEqual(empty.y1, 0)
    }

    func testEquals() {
        XCTAssertEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 1, y0: 0, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 1, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 1, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 1), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
    }
    
    func testHashable() {
        XCTAssertEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue, BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue)
        XCTAssertNotEqual(BLBoxI(x0: 1, y0: 0, x1: 0, y1: 0).hashValue, BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue)
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 1, x1: 0, y1: 0).hashValue, BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue)
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 1, y1: 0).hashValue, BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue)
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 1).hashValue, BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0).hashValue)
    }
    
    func testReset() {
        var box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)
        
        box.reset()
        
        XCTAssertEqual(box.x0, 0)
        XCTAssertEqual(box.y0, 0)
        XCTAssertEqual(box.x1, 0)
        XCTAssertEqual(box.y1, 0)
    }
    
    func testContains() {
        let box = BLBoxI(x0: 0, y0: 0, x1: 10, y1: 10)
        
        XCTAssert(box.contains(0, 0))
        XCTAssert(box.contains(5, 5))
        XCTAssertFalse(box.contains(10, 10))
        XCTAssertFalse(box.contains(-5, 5))
        XCTAssertFalse(box.contains(5, -5))
    }
    
    func testContainsPoint() {
        let box = BLBoxI(x0: 0, y0: 0, x1: 10, y1: 10)
        
        XCTAssert(box.contains(BLPointI(x: 0, y: 0)))
        XCTAssert(box.contains(BLPointI(x: 5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 10, y: 10)))
        XCTAssertFalse(box.contains(BLPointI(x: -5, y: 5)))
        XCTAssertFalse(box.contains(BLPointI(x: 5, y: -5)))
    }
    
    func testInitWithWidthAndHeight() {
        let box = BLBoxI(x: 5, y: 5, w: 10, h: 10)
        
        XCTAssertEqual(box.x0, 5)
        XCTAssertEqual(box.y0, 5)
        XCTAssertEqual(box.x1, 15)
        XCTAssertEqual(box.y1, 15)
    }
    
    func testQuadrants() {
        let box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)
        
        XCTAssertEqual(box.topLeft, BLPointI(x: 1, y: 2))
        XCTAssertEqual(box.topRight, BLPointI(x: 3, y: 2))
        XCTAssertEqual(box.bottomLeft, BLPointI(x: 1, y: 4))
        XCTAssertEqual(box.bottomRight, BLPointI(x: 3, y: 4))
    }
    
    func testWidth() {
        let box = BLBoxI(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.w, 5)
    }
    
    func testHeight() {
        let box = BLBoxI(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.h, 5)
    }

    func testAsRectangle() {
        let box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)

        XCTAssertEqual(box.asBLRectI, BLRectI(x: 1, y: 2, w: 2, h: 2))
    }
    
    func testCenter() {
        var box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)
        
        XCTAssertEqual(box.center, BLPointI(x: 2, y: 3))
        
        box.center = BLPointI(x: 5, y: 6)
        
        XCTAssertEqual(box, BLBoxI(x0: 4, y0: 5, x1: 6, y1: 7))
    }

    func testOffsetBy() {
        let box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)

        let offset = box.offsetBy(x: 10, y: 20)

        XCTAssertEqual(offset, BLBoxI(x0: 11, y0: 22, x1: 13, y1: 24))
    }

    func testInset() {
        let box = BLBoxI(x0: 0, y0: 0, x1: 10, y1: 10)
        let result = box.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.x0, 1)
        XCTAssertEqual(result.y0, 1)
        XCTAssertEqual(result.x1, 9)
        XCTAssertEqual(result.y1, 9)
    }

    func testResized() {
        let box = BLBoxI(x0: 10, y0: 10, x1: 30, y1: 30)
        let result = box.resized(width: 10, height: 10)

        XCTAssertEqual(result.x0, 10)
        XCTAssertEqual(result.y0, 10)
        XCTAssertEqual(result.x1, 20)
        XCTAssertEqual(result.y1, 20)
    }

    func testInitBoundsForPoints() {
        let box = BLBoxI(boundsForPoints: [
            BLPointI(x: -5, y: 5),
            BLPointI(x: 5, y: -5),
            BLPointI(x: 7, y: -5)
        ])

        XCTAssertEqual(box.x0, -5)
        XCTAssertEqual(box.y0, -5)
        XCTAssertEqual(box.x1, 7)
        XCTAssertEqual(box.y1, 5)
    }

    func testInitBoundsForPointsWithSinglePoint() {
        let box = BLBoxI(boundsForPoints: [
            BLPointI(x: 5, y: 5),
        ])

        XCTAssertEqual(box.x0, 5)
        XCTAssertEqual(box.y0, 5)
        XCTAssertEqual(box.x1, 5)
        XCTAssertEqual(box.y1, 5)
    }

    func testInitBoundsForPointsEmpty() {
        let box = BLBoxI(boundsForPoints: [])

        XCTAssertEqual(box, BLBoxI.empty)
    }

    func testInitWithRoundedBox() {
        let box = BLBoxI(rounding: BLBox(x0: 10.4, y0: 10.6, x1: 20.4, y1: 20.6))

        XCTAssertEqual(box.x0, 10)
        XCTAssertEqual(box.y0, 11)
        XCTAssertEqual(box.x1, 20)
        XCTAssertEqual(box.y1, 21)
    }

    func testInitWithBLRect() {
        let box = BLBoxI(roundingRect: BLRect(x: 10.1, y: 10.5, w: 20.3, h: 20.3))

        XCTAssertEqual(box.x0, 10)
        XCTAssertEqual(box.y0, 11)
        XCTAssertEqual(box.x1, 30)
        XCTAssertEqual(box.y1, 31)
    }

    func testInitWithBLRectI() {
        let box = BLBoxI(rectI: BLRectI(x: 1, y: 2, w: 3, h: 5))

        XCTAssertEqual(box.x0, 1)
        XCTAssertEqual(box.y0, 2)
        XCTAssertEqual(box.x1, 4)
        XCTAssertEqual(box.y1, 7)
    }
    
    func testDescription() {
        let box = BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)
        
        XCTAssertEqual(box.description,
                       "BLBoxI(x0: 1, y0: 2, x1: 3, y1: 4)")
    }
}
