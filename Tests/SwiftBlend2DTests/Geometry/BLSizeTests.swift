import XCTest
import SwiftBlend2D
import blend2d

class BLSizeTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLSize(w: 32, h: 48),
            BLSize(w: 32, h: 48)
        )
        XCTAssertNotEqual(
            BLSize(w: 0, h: 48),
            BLSize(w: 32, h: 48)
        )
        XCTAssertNotEqual(
            BLSize(w: 32, h: 0),
            BLSize(w: 32, h: 48)
        )
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLSize(w: 32, h: 48).hashValue,
            BLSize(w: 32, h: 48).hashValue
        )
        XCTAssertNotEqual(
            BLSize(w: 0, h: 48).hashValue,
            BLSize(w: 32, h: 48).hashValue
        )
        XCTAssertNotEqual(
            BLSize(w: 32, h: 0).hashValue,
            BLSize(w: 32, h: 48).hashValue
        )
    }

    func testAdd() {
        let result = BLSize(w: 1, h: 2) + BLSize(w: 3, h: 4)

        XCTAssertEqual(result.w, 4)
        XCTAssertEqual(result.h, 6)
    }

    func testSubtract() {
        let result = BLSize(w: 1, h: 2) - BLSize(w: 3, h: 4)

        XCTAssertEqual(result.w, -2)
        XCTAssertEqual(result.h, -2)
    }

    func testMultiply() {
        let result = BLSize(w: 1, h: 2) * BLSize(w: 3, h: 4)

        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 8)
    }

    func testDivide() {
        let result = BLSize(w: 1, h: 2) / BLSize(w: 3, h: 4)

        XCTAssertEqual(result.w, 1 / 3)
        XCTAssertEqual(result.h, 0.5)
    }

    func testAddAssign() {
        var lhs = BLSize(w: 1, h: 2)
        lhs += BLSize(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 4)
        XCTAssertEqual(lhs.h, 6)
    }

    func testSubtractAssign() {
        var lhs = BLSize(w: 1, h: 2)
        lhs -= BLSize(w: 3, h: 4)

        XCTAssertEqual(lhs.w, -2)
        XCTAssertEqual(lhs.h, -2)
    }

    func testMultiplyAssign() {
        var lhs = BLSize(w: 1, h: 2)
        lhs *= BLSize(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 3)
        XCTAssertEqual(lhs.h, 8)
    }

    func testDivideAssign() {
        var lhs = BLSize(w: 1, h: 2)
        lhs /= BLSize(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 1 / 3)
        XCTAssertEqual(lhs.h, 0.5)
    }
    
    func testDescription() {
        let size = BLSize(w: 1, h: 2)
        
        XCTAssertEqual(size.description, "BLSize(w: 1.0, h: 2.0)")
    }
}
