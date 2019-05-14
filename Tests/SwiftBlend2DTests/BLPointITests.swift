import XCTest
import blend2d
@testable import SwiftBlend2D

class BLPointITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLPointI(x: 0, y: 1), BLPointI(x: 0, y: 1))
        XCTAssertNotEqual(BLPointI(x: 1, y: 1), BLPointI(x: 0, y: 1))
        XCTAssertNotEqual(BLPointI(x: 0, y: 0), BLPointI(x: 0, y: 1))
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
}
