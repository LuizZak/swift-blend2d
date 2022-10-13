import XCTest
import blend2d
@testable import SwiftBlend2D

class BLPointITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLPointI(x: 0, y: 1),
            BLPointI(x: 0, y: 1)
        )
        XCTAssertNotEqual(
            BLPointI(x: 1, y: 1),
            BLPointI(x: 0, y: 1)
        )
        XCTAssertNotEqual(
            BLPointI(x: 0, y: 0),
            BLPointI(x: 0, y: 1)
        )
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLPointI(x: 0, y: 1).hashValue,
            BLPointI(x: 0, y: 1).hashValue
        )
        XCTAssertNotEqual(
            BLPointI(x: 1, y: 1).hashValue,
            BLPointI(x: 0, y: 1).hashValue
        )
        XCTAssertNotEqual(
            BLPointI(x: 0, y: 0).hashValue,
            BLPointI(x: 0, y: 1).hashValue
        )
    }
    
    func testZero() {
        let zero = BLPointI.zero
        
        XCTAssertEqual(zero.x, 0)
        XCTAssertEqual(zero.y, 0)
    }

    func testOne() {
        let one = BLPointI.one

        XCTAssertEqual(one.x, 1)
        XCTAssertEqual(one.y, 1)
    }
    
    func testNegate() {
        let result = -BLPointI(x: 1, y: 2)
        
        XCTAssertEqual(result.x, -1)
        XCTAssertEqual(result.y, -2)
    }

    func testAdd() {
        let result = BLPointI(x: 1, y: 2) + BLPointI(x: 3, y: 4)

        XCTAssertEqual(result.x, 4)
        XCTAssertEqual(result.y, 6)
    }

    func testSubtract() {
        let result = BLPointI(x: 1, y: 2) - BLPointI(x: 3, y: 4)

        XCTAssertEqual(result.x, -2)
        XCTAssertEqual(result.y, -2)
    }

    func testMultiply() {
        let result = BLPointI(x: 1, y: 2) * BLPointI(x: 3, y: 4)

        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 8)
    }

    func testDivide() {
        let result = BLPointI(x: 1, y: 2) / BLPointI(x: 3, y: 4)

        XCTAssertEqual(result.x, 1 / 3)
        XCTAssertEqual(result.y, 2 / 4)
    }

    func testAddAssign() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs += BLPointI(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 4)
        XCTAssertEqual(lhs.y, 6)
    }

    func testSubtractAssign() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs -= BLPointI(x: 3, y: 4)

        XCTAssertEqual(lhs.x, -2)
        XCTAssertEqual(lhs.y, -2)
    }

    func testMultiplyAssign() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs *= BLPointI(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 3)
        XCTAssertEqual(lhs.y, 8)
    }

    func testDivideAssign() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs /= BLPointI(x: 3, y: 4)

        XCTAssertEqual(lhs.x, 1 / 3)
        XCTAssertEqual(lhs.y, 2 / 4)
    }
    
    func testMultiplyDouble() {
        let result = BLPointI(x: 1, y: 2) * 3
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 6)
    }
    
    func testDivideDouble() {
        let result = BLPointI(x: 1, y: 2) / 3
        
        XCTAssertEqual(result.x, 1 / 3)
        XCTAssertEqual(result.y, 2 / 3)
    }
    
    func testMultiplyDoubleInverse() {
        let result = 3 * BLPointI(x: 1, y: 2)
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 6)
    }
    
    func testDivideDoubleInverse() {
        let result = 3 / BLPointI(x: 1, y: 2)
        
        XCTAssertEqual(result.x, 3)
        XCTAssertEqual(result.y, 3 / 2)
    }
    
    func testMultiplyAssignDouble() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs *= 3
        
        XCTAssertEqual(lhs.x, 3)
        XCTAssertEqual(lhs.y, 6)
    }
    
    func testDivideAssignDouble() {
        var lhs = BLPointI(x: 1, y: 2)
        lhs /= 3
        
        XCTAssertEqual(lhs.x, 1 / 3)
        XCTAssertEqual(lhs.y, 2 / 3)
    }

    func testPointwiseMin() {
        let p1 = BLPointI(x: 1, y: 4)
        let p2 = BLPointI(x: 2, y: 3)

        XCTAssertEqual(p1.pointwiseMin(p2), BLPointI(x: 1, y: 3))
    }

    func testPointwiseMax() {
        let p1 = BLPointI(x: 1, y: 4)
        let p2 = BLPointI(x: 2, y: 3)

        XCTAssertEqual(p1.pointwiseMax(p2), BLPointI(x: 2, y: 4))
    }

    func testDotProduct() {
        let p1 = BLPointI(x: 1, y: 2)
        let p2 = BLPointI(x: 3, y: 4)

        XCTAssertEqual(p1.dot(p2), 1 * 3 + 2 * 4)
    }

    func testInitRoundingPoint() {
        let point = BLPointI(rounding: BLPoint(x: 10.6, y: 10.4))

        XCTAssertEqual(point.x, 11)
        XCTAssertEqual(point.y, 10)
    }
    
    func testDescription() {
        let point = BLPointI(x: 1, y: 2)
        
        XCTAssertEqual(
            point.description,
            "BLPointI(x: 1, y: 2)"
        )
    }
}
