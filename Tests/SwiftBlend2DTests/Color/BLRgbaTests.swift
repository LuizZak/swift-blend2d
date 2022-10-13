import XCTest
import blend2d
import SwiftBlend2D

class BLRgbaTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLRgba(r: 1, g: 2, b: 3, a: 4),
            BLRgba(r: 1, g: 2, b: 3, a: 4)
        )
        
        XCTAssertNotEqual(
            BLRgba(r: 9, g: 2, b: 3, a: 4),
            BLRgba(r: 1, g: 2, b: 3, a: 4)
        )
        XCTAssertNotEqual(
            BLRgba(r: 1, g: 9, b: 3, a: 4),
            BLRgba(r: 1, g: 2, b: 3, a: 4)
        )
        XCTAssertNotEqual(
            BLRgba(r: 1, g: 2, b: 9, a: 4),
            BLRgba(r: 1, g: 2, b: 3, a: 4)
        )
        XCTAssertNotEqual(
            BLRgba(r: 1, g: 2, b: 3, a: 9),
            BLRgba(r: 1, g: 2, b: 3, a: 4)
        )
    }

    func testWithTransparency() {
        let color = BLRgba(r: 1, g: 2, b: 3, a: 4).withTransparency(10.0)

        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 10)
    }

    func testFadedTowards() {
        let first = BLRgba(r: 0.1, g: 0.1, b: 0.1, a: 0)
        let second = BLRgba(r: 0.5, g: 0.3, b: 0.3, a: 1)

        XCTAssertEqual(
            first.faded(towards: second, factor: 0),
            first
        )
        XCTAssertEqual(
            first.faded(towards: second, factor: 1),
            BLRgba(r: 0.5, g: 0.3, b: 0.3, a: 0)
        )
        XCTAssertEqual(
            first.faded(towards: second, factor: 0.5),
            BLRgba(r: 0.3, g: 0.2, b: 0.2, a: 0)
        )
        XCTAssertEqual(
            first.faded(towards: second, factor: 0.5, blendAlpha: true),
            BLRgba(r: 0.3, g: 0.2, b: 0.2, a: 0.5)
        )
    }
}
