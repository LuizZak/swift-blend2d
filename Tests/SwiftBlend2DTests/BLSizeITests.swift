import XCTest
import SwiftBlend2D
import blend2d

class BLSizeITests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLSizeI(w: 32, h: 48), BLSizeI(w: 32, h: 48))
        XCTAssertNotEqual(BLSizeI(w: 0, h: 48), BLSizeI(w: 32, h: 48))
        XCTAssertNotEqual(BLSizeI(w: 32, h: 0), BLSizeI(w: 32, h: 48))
    }
}
