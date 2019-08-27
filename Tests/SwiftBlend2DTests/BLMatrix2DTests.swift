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
    
    func testInverted() {
        let matrix = BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6)
        
        let result = matrix.inverted
        
        XCTAssertEqual(result.m00, -2)
        XCTAssertEqual(result.m01, 1)
        XCTAssertEqual(result.m10, 1.5)
        XCTAssertEqual(result.m11, -0.5)
        XCTAssertEqual(result.m20, 1)
        XCTAssertEqual(result.m21, -2)
    }
    
    func testTwiceInverted() {
        let matrix = BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6)
        
        let result = matrix.inverted.inverted
        
        XCTAssertEqual(result.m00, 1)
        XCTAssertEqual(result.m01, 2)
        XCTAssertEqual(result.m10, 3)
        XCTAssertEqual(result.m11, 4)
        XCTAssertEqual(result.m20, 5)
        XCTAssertEqual(result.m21, 6)
    }
    
    func testMultiply() {
        let matrix1 = BLMatrix2D(m00: 1, m01: 2, m10: 3, m11: 4, m20: 5, m21: 6)
        let matrix2 = BLMatrix2D(m00: 6, m01: 5, m10: 4, m11: 3, m20: 2, m21: 1)
        
        let result = matrix1 * matrix2
        
        XCTAssertEqual(result.m00, 14)
        XCTAssertEqual(result.m01, 11)
        XCTAssertEqual(result.m10, 34)
        XCTAssertEqual(result.m11, 27)
        XCTAssertEqual(result.m20, 56)
        XCTAssertEqual(result.m21, 44)
    }
    
    func testMultiplyPoint() {
        let matrix = BLMatrix2D.makeRotation(angle: .pi) * BLMatrix2D.makeScaling(x: 0.5, y: 0.5) * BLMatrix2D.makeTranslation(x: 10, y: 20)
        let point = BLPoint(x: 10, y: 10)
        
        let result = point * matrix
        
        XCTAssert(abs(result.x - 5) < 1e-10)
        XCTAssert(abs(result.y - 15) < 1e-10)
    }

    func testMapPolygon() {
        let matrix = BLMatrix2D.makeRotation(angle: .pi) * BLMatrix2D.makeScaling(x: 0.5, y: 0.5) * BLMatrix2D.makeTranslation(x: 10, y: 20)
        let points = [
            BLPoint(x: -10, y: -10),
            BLPoint(x: 10, y: -10),
            BLPoint(x: 10, y: 10),
            BLPoint(x: -10, y: 10)
        ]
        let expected = [
            BLPoint(x: 15, y: 25),
            BLPoint(x: 5, y: 25),
            BLPoint(x: 5, y: 15),
            BLPoint(x: 15, y: 15)
        ]
        
        let result = matrix.mapPolygon(points)
        
        assertPolygonsEqual(expected, result)
    }

    func assertPolygonsEqual(_ expected: [BLPoint], _ actual: [BLPoint], line: UInt = #line) {
        var mismatch = false
        for (actual, expected) in zip(actual, expected) {
            if abs((actual - expected).x) < 1e-10 {
                mismatch = true
                break
            }
            if abs((actual - expected).y) < 1e-10 {
                mismatch = true
                break
            }
        }

        if mismatch {
            XCTFail("Expected polygon \(expected) but received \(actual)", line: line)
        }
    }
}
