import XCTest
import blend2d
import SwiftBlend2D

class BLGlyphItemTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLGlyphItem(.init(value: 1)),
                       BLGlyphItem(.init(value: 1)))
        
        XCTAssertNotEqual(BLGlyphItem(.init(value: 9)),
                          BLGlyphItem(.init(value: 1)))
    }
}
