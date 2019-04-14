import XCTest
import SwiftBlend2D
import blend2d

class BLSizeTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLSize(w: 32, h: 48), BLSize(w: 32, h: 48))
        XCTAssertNotEqual(BLSize(w: 0, h: 48), BLSize(w: 32, h: 48))
        XCTAssertNotEqual(BLSize(w: 32, h: 0), BLSize(w: 32, h: 48))
    }
}
