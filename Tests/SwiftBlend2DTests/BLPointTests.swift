import XCTest
import blend2d
@testable import SwiftBlend2D

class BLPointTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLPoint(x: 0, y: 1), BLPoint(x: 0, y: 1))
        XCTAssertNotEqual(BLPoint(x: 1, y: 1), BLPoint(x: 0, y: 1))
        XCTAssertNotEqual(BLPoint(x: 0, y: 0), BLPoint(x: 0, y: 1))
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
}
