import XCTest
import blend2d
@testable import SwiftBlend2D

class BLTriangleTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)),
                       BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 9, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 0, y: 9), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 9, y: 3), p2: BLPoint(x: 4, y: 5)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 9), p2: BLPoint(x: 4, y: 5)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 9, y: 5)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 9)),
                          BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5)))
    }
    
    func testInitWithPoints() {
        let sut = BLTriangle(p0: BLPoint(x: 0, y: 1), p1: BLPoint(x: 2, y: 3), p2: BLPoint(x: 4, y: 5))
        
        XCTAssertEqual(sut.x0, 0)
        XCTAssertEqual(sut.y0, 1)
        XCTAssertEqual(sut.x1, 2)
        XCTAssertEqual(sut.y1, 3)
        XCTAssertEqual(sut.x2, 4)
        XCTAssertEqual(sut.y2, 5)
    }
    
    func testInitWithCoordinates() {
        let sut = BLTriangle(x0: 0, y0: 1, x1: 2, y1: 3, x2: 4, y2: 5)
        
        XCTAssertEqual(sut.x0, 0)
        XCTAssertEqual(sut.y0, 1)
        XCTAssertEqual(sut.x1, 2)
        XCTAssertEqual(sut.y1, 3)
        XCTAssertEqual(sut.x2, 4)
        XCTAssertEqual(sut.y2, 5)
    }

    func testContains() {
        // A right triangle
        // ◺
        let sut = BLTriangle(x0: 0, y0: 0, x1: 10, y1: 10, x2: 0, y2: 10)

        XCTAssert(sut.contains(x: 0, y: 0))
        XCTAssert(sut.contains(x: 5, y: 5))
        XCTAssert(sut.contains(x: 1, y: 9))
        XCTAssert(sut.contains(x: 10, y: 10))
        XCTAssertFalse(sut.contains(x: 11, y: 11))
        XCTAssertFalse(sut.contains(x: -1, y: 0))
    }

    func testContainsPoint() {
        // A right triangle
        // ◺
        let sut = BLTriangle(x0: 0, y0: 0, x1: 10, y1: 10, x2: 0, y2: 10)

        XCTAssert(sut.contains(BLPoint(x: 0, y: 0)))
        XCTAssert(sut.contains(BLPoint(x: 5, y: 5)))
        XCTAssert(sut.contains(BLPoint(x: 1, y: 9)))
        XCTAssert(sut.contains(BLPoint(x: 10, y: 10)))
        XCTAssertFalse(sut.contains(BLPoint(x: 11, y: 11)))
        XCTAssertFalse(sut.contains(BLPoint(x: -1, y: 0)))
    }
    
    func testBounds() {
        let sut = BLTriangle(x0: -5, y0: -5, x1: 10, y1: 10, x2: -8, y2: 7)
        
        XCTAssertEqual(sut.bounds, BLRect(x: -8.0, y: -5.0, w: 18.0, h: 15.0))
    }
    
    func testUnitEquilateral() {
        let unit = BLTriangle.unitEquilateral
        
        XCTAssertEqual(unit.centroid.x, 0, accuracy: 1e-10)
        XCTAssertEqual(unit.centroid.y, 0, accuracy: 1e-10)
        XCTAssertEqual(unit.p0.distanceSquared(to: unit.p1), 1, accuracy: 1e-8)
        XCTAssertEqual(unit.p1.distanceSquared(to: unit.p2), 1, accuracy: 1e-8)
        XCTAssertEqual(unit.p2.distanceSquared(to: unit.p0), 1, accuracy: 1e-8)
    }
    
    func testScaledBy() {
        let unit = BLTriangle.unitEquilateral.offsetBy(x: 1, y: 1)
        let result = unit.scaledBy(x: 1, y: 2)
        
        XCTAssertEqual(result.centroid.x, 1, accuracy: 1e-10)
        XCTAssertEqual(result.centroid.y, 1, accuracy: 1e-10)
        XCTAssertEqual(result.bounds.size.w, 1, accuracy: 1e-8)
        XCTAssertEqual(result.bounds.size.h, 0.866025404 * 2, accuracy: 1e-8)
        XCTAssertEqual(result.p0.distanceSquared(to: result.p1), 3.25, accuracy: 1e-8)
        XCTAssertEqual(result.p1.distanceSquared(to: result.p2), 1, accuracy: 1e-8)
        XCTAssertEqual(result.p2.distanceSquared(to: result.p0), 3.25, accuracy: 1e-8)
    }
    
    func testOffsetBy() {
        let triangle = BLTriangle(p0: .zero, p1: .one, p2: BLPoint(x: 0, y: 1))
        let result = triangle.offsetBy(x: 3, y: 4)
        
        XCTAssertEqual(result.x0, 3)
        XCTAssertEqual(result.y0, 4)
        XCTAssertEqual(result.x1, 4)
        XCTAssertEqual(result.y1, 5)
        XCTAssertEqual(result.x2, 3)
        XCTAssertEqual(result.y2, 5)
    }
}
