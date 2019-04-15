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
}
