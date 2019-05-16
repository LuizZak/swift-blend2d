import XCTest
import blend2d
import SwiftBlend2D

class BLBoxITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 1, y0: 0, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 1, x1: 0, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 1, y1: 0), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
        XCTAssertNotEqual(BLBoxI(x0: 0, y0: 0, x1: 0, y1: 1), BLBoxI(x0: 0, y0: 0, x1: 0, y1: 0))
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
        let box = BLBoxI(x: 5, y: 5, width: 10, height: 10)
        
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

        XCTAssertEqual(box.asRectangle, BLRectI(x: 1, y: 2, w: 2, h: 2))
    }
}
