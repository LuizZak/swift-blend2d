import XCTest
import blend2d
import SwiftBlend2D

class BLFontCoverageInfoTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLFontCoverageInfo(data: (0, 1, 2, 3)),
            BLFontCoverageInfo(data: (0, 1, 2, 3))
        )

        XCTAssertNotEqual(
            BLFontCoverageInfo(data: (9, 1, 2, 3)),
            BLFontCoverageInfo(data: (0, 1, 2, 3))
        )

        XCTAssertNotEqual(
            BLFontCoverageInfo(data: (0, 9, 2, 3)),
            BLFontCoverageInfo(data: (0, 1, 2, 3))
        )

        XCTAssertNotEqual(
            BLFontCoverageInfo(data: (0, 1, 9, 3)),
            BLFontCoverageInfo(data: (0, 1, 2, 3))
        )

        XCTAssertNotEqual(
            BLFontCoverageInfo(data: (0, 1, 2, 9)),
            BLFontCoverageInfo(data: (0, 1, 2, 3))
        )
    }
}
