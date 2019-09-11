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
}
