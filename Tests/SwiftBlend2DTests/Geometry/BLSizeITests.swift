import XCTest
import SwiftBlend2D
import blend2d

class BLSizeITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLSizeI(w: 32, h: 48), BLSizeI(w: 32, h: 48))
        XCTAssertNotEqual(BLSizeI(w: 0, h: 48), BLSizeI(w: 32, h: 48))
        XCTAssertNotEqual(BLSizeI(w: 32, h: 0), BLSizeI(w: 32, h: 48))
    }
    
    func testHashable() {
        XCTAssertEqual(
            BLSizeI(w: 32, h: 48).hashValue,
            BLSizeI(w: 32, h: 48).hashValue
        )
        XCTAssertNotEqual(
            BLSizeI(w: 0, h: 48).hashValue,
            BLSizeI(w: 32, h: 48).hashValue
        )
        XCTAssertNotEqual(
            BLSizeI(w: 32, h: 0).hashValue,
            BLSizeI(w: 32, h: 48).hashValue
        )
    }
    
    func testAdd() {
        let result = BLSizeI(w: 1, h: 2) + BLSizeI(w: 3, h: 4)

        XCTAssertEqual(result.w, 4)
        XCTAssertEqual(result.h, 6)
    }

    func testSubtract() {
        let result = BLSizeI(w: 1, h: 2) - BLSizeI(w: 3, h: 4)

        XCTAssertEqual(result.w, -2)
        XCTAssertEqual(result.h, -2)
    }

    func testMultiply() {
        let result = BLSizeI(w: 1, h: 2) * BLSizeI(w: 3, h: 4)

        XCTAssertEqual(result.w, 3)
        XCTAssertEqual(result.h, 8)
    }

    func testDivide() {
        let result = BLSizeI(w: 1, h: 2) / BLSizeI(w: 3, h: 4)

        XCTAssertEqual(result.w, 1 / 3)
        XCTAssertEqual(result.h, 0)
    }

    func testAddAssign() {
        var lhs = BLSizeI(w: 1, h: 2)
        lhs += BLSizeI(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 4)
        XCTAssertEqual(lhs.h, 6)
    }

    func testSubtractAssign() {
        var lhs = BLSizeI(w: 1, h: 2)
        lhs -= BLSizeI(w: 3, h: 4)

        XCTAssertEqual(lhs.w, -2)
        XCTAssertEqual(lhs.h, -2)
    }

    func testMultiplyAssign() {
        var lhs = BLSizeI(w: 1, h: 2)
        lhs *= BLSizeI(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 3)
        XCTAssertEqual(lhs.h, 8)
    }

    func testDivideAssign() {
        var lhs = BLSizeI(w: 1, h: 2)
        lhs /= BLSizeI(w: 3, h: 4)

        XCTAssertEqual(lhs.w, 1 / 3)
        XCTAssertEqual(lhs.h, 0)
    }
    
    func testDescription() {
        let size = BLSizeI(w: 1, h: 2)
        
        XCTAssertEqual(size.description, "BLSizeI(w: 1, h: 2)")
    }
}
