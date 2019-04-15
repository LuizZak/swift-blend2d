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
}
