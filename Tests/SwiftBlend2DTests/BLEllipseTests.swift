import XCTest
import blend2d
@testable import SwiftBlend2D

class BLEllipseTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4),
                       BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        
        XCTAssertNotEqual(BLEllipse(cx: 9, cy: 2, rx: 3, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 9, rx: 3, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 9, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 9),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
    }
    
    func testHashable() {
        XCTAssertEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue,
                       BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue)
        
        XCTAssertNotEqual(BLEllipse(cx: 9, cy: 2, rx: 3, ry: 4).hashValue,
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue)
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 9, rx: 3, ry: 4).hashValue,
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue)
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 9, ry: 4).hashValue,
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue)
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 9).hashValue,
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4).hashValue)
    }
    
    func testInitWithCoordinates() {
        let circle = BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.rx, 3)
        XCTAssertEqual(circle.ry, 4)
    }
    
    func testInitWithPoint() {
        let circle = BLEllipse(center: BLPoint(x: 1, y: 2), radius: BLPoint(x: 3, y: 4))
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.rx, 3)
        XCTAssertEqual(circle.ry, 4)
    }

    func testInset() {
        let ellipse = BLEllipse(cx: 0, cy: 0, rx: 10, ry: 10)
        let result = ellipse.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.cx, 1)
        XCTAssertEqual(result.cy, 1)
        XCTAssertEqual(result.rx, 8)
        XCTAssertEqual(result.ry, 8)
    }

    func testContains() {
        let ellipse = BLEllipse(cx: 10, cy: 10, rx: 2, ry: 1)

        XCTAssert(ellipse.contains(x: 10, y: 10))
        XCTAssert(ellipse.contains(x: 10.5, y: 10.5))
        XCTAssert(ellipse.contains(x: 11, y: 10))
        XCTAssertFalse(ellipse.contains(x: 12, y: 10))
        XCTAssertFalse(ellipse.contains(x: 12, y: 8))
    }

    func testContainsPoint() {
        let ellipse = BLEllipse(cx: 10, cy: 10, rx: 2, ry: 1)

        XCTAssert(ellipse.contains(BLPoint(x: 10, y: 10)))
        XCTAssert(ellipse.contains(BLPoint(x: 10.5, y: 10.5)))
        XCTAssert(ellipse.contains(BLPoint(x: 11, y: 10)))
        XCTAssertFalse(ellipse.contains(BLPoint(x: 12, y: 10)))
        XCTAssertFalse(ellipse.contains(BLPoint(x: 12, y: 8)))
    }
    
    func testBoundingBox() {
        let ellipse = BLEllipse(cx: 5, cy: 10, rx: 2, ry: 1)
        let result = ellipse.boundingBox
        
        XCTAssertEqual(result.x0, 3)
        XCTAssertEqual(result.y0, 9)
        XCTAssertEqual(result.x1, 7)
        XCTAssertEqual(result.y1, 11)
    }
    
    func testDescription() {
        let ellipse = BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4)
        
        XCTAssertEqual(ellipse.description,
                       "BLEllipse(cx: 1.0, cy: 2.0, rx: 3.0, ry: 4.0)")
    }
}
