import XCTest
import blend2d
@testable import SwiftBlend2D

class BLCircleTests: XCTestCase {
    func testUnitCircle() {
        XCTAssertEqual(BLCircle.unitCircle.cx, 0)
        XCTAssertEqual(BLCircle.unitCircle.cy, 0)
        XCTAssertEqual(BLCircle.unitCircle.r, 0.5)
    }
    
    func testDiameter() {
        let sut = BLCircle(cx: 0, cy: 0, r: 1)
        
        XCTAssertEqual(sut.diameter, 2)
    }
    
    func testDiameter_set() {
        var sut = BLCircle(cx: 0, cy: 0, r: 1)
        
        sut.diameter = 3
        
        XCTAssertEqual(sut.r, 1.5)
    }
    
    func testEquals() {
        XCTAssertEqual(
            BLCircle(cx: 1, cy: 2, r: 3),
            BLCircle(cx: 1, cy: 2, r: 3)
        )
        
        XCTAssertNotEqual(
            BLCircle(cx: 9, cy: 2, r: 3),
            BLCircle(cx: 1, cy: 2, r: 3)
        )
        XCTAssertNotEqual(
            BLCircle(cx: 1, cy: 9, r: 3),
            BLCircle(cx: 1, cy: 2, r: 3)
        )
        XCTAssertNotEqual(
            BLCircle(cx: 1, cy: 2, r: 9),
            BLCircle(cx: 1, cy: 2, r: 3)
        )
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLCircle(cx: 1, cy: 2, r: 3).hashValue,
            BLCircle(cx: 1, cy: 2, r: 3).hashValue
        )
        
        XCTAssertNotEqual(
            BLCircle(cx: 9, cy: 2, r: 3).hashValue,
            BLCircle(cx: 1, cy: 2, r: 3).hashValue
        )
        XCTAssertNotEqual(
            BLCircle(cx: 1, cy: 9, r: 3).hashValue,
            BLCircle(cx: 1, cy: 2, r: 3).hashValue
        )
        XCTAssertNotEqual(
            BLCircle(cx: 1, cy: 2, r: 9).hashValue,
            BLCircle(cx: 1, cy: 2, r: 3).hashValue
        )
    }
    
    func testInitWithCoordinates() {
        let circle = BLCircle(cx: 1, cy: 2, r: 3)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.r, 3)
    }
    
    func testInitWithPoint() {
        let circle = BLCircle(center: BLPoint(x: 1, y: 2), radius: 3)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.r, 3)
    }

    func testExpandedBy() {
        let circle = BLCircle(cx: 2, cy: 2, r: 4)
        let expanded = circle.expanded(by: 2)

        XCTAssertEqual(expanded.cx, 2)
        XCTAssertEqual(expanded.cy, 2)
        XCTAssertEqual(expanded.r, 6)
    }
    
    func testCenter() {
        var circle = BLCircle(cx: 1, cy: 2, r: 3)
        
        XCTAssertEqual(circle.center, BLPoint(x: 1, y: 2))
        
        circle.center = BLPoint(x: 5, y: 6)
        
        XCTAssertEqual(circle, BLCircle(cx: 5, cy: 6, r: 3))
    }
    
    func testBoundingBox() {
        let circle = BLCircle(cx: 1, cy: 2, r: 3)
        
        XCTAssertEqual(circle.boundingBox, BLBox(x0: -2, y0: -1, x1: 4, y1: 5))
    }

    func testContains() {
        let circle = BLCircle(cx: 10, cy: 10, r: 1)

        XCTAssert(circle.contains(x: 10, y: 10))
        XCTAssert(circle.contains(x: 10.5, y: 10.5))
        XCTAssertFalse(circle.contains(x: 11, y: 10))
        XCTAssertFalse(circle.contains(x: 12, y: 8))
    }

    func testContainsPoint() {
        let circle = BLCircle(cx: 10, cy: 10, r: 1)

        XCTAssert(circle.contains(BLPoint(x: 10, y: 10)))
        XCTAssert(circle.contains(BLPoint(x: 10.5, y: 10.5)))
        XCTAssertFalse(circle.contains(BLPoint(x: 11, y: 10)))
        XCTAssertFalse(circle.contains(BLPoint(x: 12, y: 8)))
    }
    
    func testDescription() {
        let circle = BLCircle(cx: 1, cy: 2, r: 3)
        
        XCTAssertEqual(
            circle.description,
            "BLCircle(cx: 1.0, cy: 2.0, r: 3.0)"
        )
    }
}
