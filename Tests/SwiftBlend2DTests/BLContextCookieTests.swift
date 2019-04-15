import XCTest
import blend2d
import SwiftBlend2D

class BLContextCookieTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLContextCookie(data: (1, 2)), BLContextCookie(data: (1, 2)))
        
        XCTAssertNotEqual(BLContextCookie(data: (9, 2)), BLContextCookie(data: (1, 2)))
        XCTAssertNotEqual(BLContextCookie(data: (1, 9)), BLContextCookie(data: (1, 2)))
    }
}
