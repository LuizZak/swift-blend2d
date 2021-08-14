import XCTest
import blend2d
@testable import SwiftBlend2D

class BLLineTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 3),
                       BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        
        XCTAssertNotEqual(BLLine(x0: 1, y0: 1, x1: 2, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 2, x1: 2, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 3, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 4),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
    }
    
    func testHashable() {
        XCTAssertEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue,
                       BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue)
        
        XCTAssertNotEqual(BLLine(x0: 1, y0: 1, x1: 2, y1: 3).hashValue,
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue)
        XCTAssertNotEqual(BLLine(x0: 0, y0: 2, x1: 2, y1: 3).hashValue,
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue)
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 3, y1: 3).hashValue,
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue)
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 4).hashValue,
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3).hashValue)
    }
    
    func testInitWithPoints() {
        let line = BLLine(start: BLPoint(x: 0, y: 1), end: BLPoint(x: 2, y: 3))
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }
    
    func testInitWithCoordinates() {
        let line = BLLine(x0: 0, y0: 1, x1: 2, y1: 3)
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }

    func testStart() {
        var line = BLLine(x0: 0, y0: 1, x1: 2, y1: 3)

        XCTAssertEqual(line.start, BLPoint(x: 0, y: 1))

        line.start = BLPoint(x: 4, y: 5)

        XCTAssertEqual(line.start, BLPoint(x: 4, y: 5))
    }

    func testEnd() {
        var line = BLLine(x0: 0, y0: 1, x1: 2, y1: 3)

        XCTAssertEqual(line.end, BLPoint(x: 2, y: 3))

        line.end = BLPoint(x: 4, y: 5)

        XCTAssertEqual(line.end, BLPoint(x: 4, y: 5))
    }
    
    func testMid() {
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 0, y1: 0).center, BLPoint(x: 0, y: 0))
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 100, y1: 100).center, BLPoint(x: 50, y: 50))
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 100, y1: 0).center, BLPoint(x: 50, y: 0))
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 0, y1: 100).center, BLPoint(x: 0, y: 50))
    }
    
    func testLength() {
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 0, y1: 0).length, 0, accuracy: 1e-15)
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 100, y1: 0).length, 100, accuracy: 1e-15)
        XCTAssertEqual(BLLine(x0: 0, y0: 0, x1: 0, y1: 100).length, 100, accuracy: 1e-15)
        XCTAssertEqual(BLLine(x0: 10, y0: 20, x1: 30, y1: 40).length, 28.284271247461902, accuracy: 1e-15)
    }

    func testRotateLeft() {
        var line = BLLine(x0: 2, y0: 2, x1: 8, y1: 8)

        line.rotateLeft()

        XCTAssertEqual(line.x0, 2)
        XCTAssertEqual(line.y0, 8)
        XCTAssertEqual(line.x1, 8)
        XCTAssertEqual(line.y1, 2)
    }

    func testRotateRight() {
        var line = BLLine(x0: 2, y0: 2, x1: 8, y1: 8)

        line.rotateRight()

        XCTAssertEqual(line.x0, 8)
        XCTAssertEqual(line.y0, 2)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 8)
    }

    func testLeftRotated() {
        var line = BLLine(x0: 2, y0: 2, x1: 8, y1: 8)
        
        line = line.leftRotated()

        XCTAssertEqual(line.x0, 2)
        XCTAssertEqual(line.y0, 8)
        XCTAssertEqual(line.x1, 8)
        XCTAssertEqual(line.y1, 2)
    }

    func testRightRotated() {
        var line = BLLine(x0: 2, y0: 2, x1: 8, y1: 8)
        
        line = line.rightRotated()

        XCTAssertEqual(line.x0, 8)
        XCTAssertEqual(line.y0, 2)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 8)
    }
    
    func testRotatedBy() {
        var line = BLLine(x0: 10, y0: 10, x1: 30, y1: 30)
        
        line = line.rotated(by: .pi)
        
        XCTAssertEqual(line.x0, 30, accuracy: 1e-15)
        XCTAssertEqual(line.y0, 30, accuracy: 1e-15)
        XCTAssertEqual(line.x1, 10, accuracy: 1e-14)
        XCTAssertEqual(line.y1, 10, accuracy: 1e-14)
    }
    
    func testDescription() {
        let line = BLLine(x0: 0, y0: 1, x1: 2, y1: 3)
        
        XCTAssertEqual(line.description,
                       "BLLine(x0: 0.0, y0: 1.0, x1: 2.0, y1: 3.0)")
    }
}
