import XCTest
import blend2d
import SwiftBlend2D

class BLMatrix2DTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        
        XCTAssertNotEqual(
            BLMatrix2D(m00: 9, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        XCTAssertNotEqual(
            BLMatrix2D(m00: 1, m01: 9, m10: 3, m11: 4, m20: 5, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        XCTAssertNotEqual(
            BLMatrix2D(m00: 1, m01: 2, m10: 9, m11: 4, m20: 5, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        XCTAssertNotEqual(
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 9, m20: 5, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        XCTAssertNotEqual(
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 9, m21: 6),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
        XCTAssertNotEqual(
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 9),
            BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6))
    }
    
    func testInitWithValues() {
        let matrix = BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6)
        
        XCTAssertEqual(matrix.m00, 1)
        XCTAssertEqual(matrix.m01, 2)
        XCTAssertEqual(matrix.m10, 3)
        XCTAssertEqual(matrix.m11, 4)
        XCTAssertEqual(matrix.m20, 5)
        XCTAssertEqual(matrix.m21, 6)
    }
}
