import XCTest
import blend2d
@testable import SwiftBlend2D

class BLPointTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLPoint(x: 0, y: 1), BLPoint(x: 0, y: 1))
        XCTAssertNotEqual(BLPoint(x: 1, y: 1), BLPoint(x: 0, y: 1))
        XCTAssertNotEqual(BLPoint(x: 0, y: 0), BLPoint(x: 0, y: 1))
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLPoint(x: 0, y: 1).hashValue,
            BLPoint(x: 0, y: 1).hashValue
        )
        XCTAssertNotEqual(
            BLPoint(x: 1, y: 1).hashValue,
            BLPoint(x: 0, y: 1).hashValue
        )
        XCTAssertNotEqual(
            BLPoint(x: 0, y: 0).hashValue,
            BLPoint(x: 0, y: 1).hashValue
        )
    }
    
    func testZero() {
        let zero = BLPoint.zero
        
        XCTAssertEqual(zero.x, 0)
        XCTAssertEqual(zero.y, 0)
    }

    func testOne() {
        let one = BLPoint.one

        XCTAssertEqual(one.x, 1)
        XCTAssertEqual(one.y, 1)
    }
    
    func testInitWithBLPointI() {
        let point = BLPoint(BLPointI(x: 1, y: 2))
        
        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)
    }
    
    func testNegate() {
        let result = -BLPoint(x: 1, y: 2)
        
        XCTAssertEqual(result.x, -1)
        XCTAssertEqual(result.y, -2)
    }

    func testAdd() {
        let result = BLPoint(x: 1, y: 2) + BLPoint(x: 3, y: 4)

        XCTAssertEqual(result.x, 4)
        XCTAssertEqual(result.y, 6)
    }

    func testSubtract() {
        let result = BLPoint(x: 1, y: 2) - BLPoint(x: 3, y: 4)

        XCTAssertEqual(result.x, -2)
        XCTAssertEqual(result.y, -2)
    }

    func testMultiply() {
        let result = BLPoint(x: 1, y: 2) * BLPoint(x: 3, y: 4)

        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 8)
    }

    func testDivide() {
        let result = BLPoint(x: 1, y: 2) / BLPoint(x: 3, y: 4)

        XCTAssertEqual(result.x, 1 / 3)
        XCTAssertEqual(result.y, 0.5)
    }

    func testAddAssign() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs += BLPoint(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 4)
        XCTAssertEqual(lhs.y, 6)
    }

    func testSubtractAssign() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs -= BLPoint(x: 3, y: 4)

        XCTAssertEqual(lhs.x, -2)
        XCTAssertEqual(lhs.y, -2)
    }

    func testMultiplyAssign() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs *= BLPoint(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 3)
        XCTAssertEqual(lhs.y, 8)
    }

    func testDivideAssign() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs /= BLPoint(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 1 / 3)
        XCTAssertEqual(lhs.y, 0.5)
    }
    
    func testMultiplyDouble() {
        let result = BLPoint(x: 1, y: 2) * 3
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 6)
    }
    
    func testDivideDouble() {
        let result = BLPoint(x: 1, y: 2) / 3
        
        XCTAssertEqual(result.x, 1 / 3)
        XCTAssertEqual(result.y, 2 / 3)
    }
    
    func testMultiplyDoubleInverse() {
        let result = 3 * BLPoint(x: 1, y: 2)
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 6)
    }
    
    func testDivideDoubleInverse() {
        let result = 3 / BLPoint(x: 1, y: 2)
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 3 / 2)
    }
    
    func testMultiplyAssignDouble() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs *= 3
        
        XCTAssertEqual(lhs.x, 3)
        XCTAssertEqual(lhs.y, 6)
    }
    
    func testDivideAssignDouble() {
        var lhs = BLPoint(x: 1, y: 2)
        lhs /= 3
        
        XCTAssertEqual(lhs.x, 1 / 3)
        XCTAssertEqual(lhs.y, 2 / 3)
    }

    func testPointwiseMin() {
        let p1 = BLPoint(x: 1, y: 4)
        let p2 = BLPoint(x: 2, y: 3)

        XCTAssertEqual(p1.pointwiseMin(p2), BLPoint(x: 1, y: 3))
    }

    func testPointwiseMax() {
        let p1 = BLPoint(x: 1, y: 4)
        let p2 = BLPoint(x: 2, y: 3)

        XCTAssertEqual(p1.pointwiseMax(p2), BLPoint(x: 2, y: 4))
    }

    func testMagnitude() {
        let p = BLPoint(x: 1, y: 1)

        XCTAssertEqual(p.magnitude, sqrt(2))
    }

    func testNormalized() {
        let p = BLPoint(x: 10, y: 10)

        XCTAssertEqual(
            p.normalized,
            BLPoint(x: 10 / sqrt(200), y: 10 / sqrt(200))
        )
    }

    func testNormalizedOnZero() {
        let p = BLPoint.zero

        XCTAssertEqual(p.normalized, .zero)
    }

    func testDotProduct() {
        let p1 = BLPoint(x: 1, y: 2)
        let p2 = BLPoint(x: 3, y: 4)

        XCTAssertEqual(p1.dot(p2), 1 * 3 + 2 * 4)
    }
    
    func testRotatedBy() {
        let point = BLPoint(x: 0, y: 1)
        let result = point.rotated(by: -.pi / 2)
        
        XCTAssertEqual(result.x, 1, accuracy: 1e-15)
        XCTAssertEqual(result.y, 0, accuracy: 1e-15)
    }
    
    func testRotatedAroundBy() {
        let point = BLPoint(x: 0, y: 1)
        let result = point.rotated(around: BLPoint(x: 1, y: 1), by: .pi / 2)
        
        XCTAssertEqual(result.x, 1, accuracy: 1e-15)
        XCTAssertEqual(result.y, 0, accuracy: 1e-15)
    }
    
    func testDistanceTo() {
        let p1 = BLPoint(x: 1, y: 2)
        let p2 = BLPoint(x: 3, y: 4)
        
        XCTAssertEqual(p1.distance(to: p2), 2.8284271247461903)
    }
    
    func testDistanceSquaredTo() {
        let p1 = BLPoint(x: 1, y: 2)
        let p2 = BLPoint(x: 3, y: 4)
        
        XCTAssertEqual(p1.distanceSquared(to: p2), 8)
    }
    
    func testDescription() {
        let point = BLPoint(x: 1, y: 2)
        
        XCTAssertEqual(
            point.description,
            "BLPoint(x: 1.0, y: 2.0)"
        )
    }
}
