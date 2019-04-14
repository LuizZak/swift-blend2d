import XCTest
import blend2d
import SwiftBlend2D

class BLBoxTests: XCTestCase {
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
    
    func testInitWithWidthAndHeight() {
        let box = BLBox(x: 5, y: 5, width: 10, height: 10)
        
        XCTAssertEqual(box.x0, 5)
        XCTAssertEqual(box.y0, 5)
        XCTAssertEqual(box.x1, 15)
        XCTAssertEqual(box.y1, 15)
    }
    
    func testWidth() {
        let box = BLBox(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.width, 5)
    }
    
    func testHeight() {
        let box = BLBox(x0: 5, y0: 5, x1: 10, y1: 10)
        
        XCTAssertEqual(box.height, 5)
    }
}
