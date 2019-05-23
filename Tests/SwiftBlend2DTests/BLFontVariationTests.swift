import XCTest
import blend2d
import SwiftBlend2D

class BLFontVariationTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLFontVariation(tag: 1, value: 2),
                       BLFontVariation(tag: 1, value: 2))
        
        XCTAssertNotEqual(BLFontVariation(tag: 9, value: 2),
                          BLFontVariation(tag: 1, value: 2))
        XCTAssertNotEqual(BLFontVariation(tag: 1, value: 9),
                          BLFontVariation(tag: 1, value: 2))
    }
}
