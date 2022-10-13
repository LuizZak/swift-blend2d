import XCTest
import blend2d
import SwiftBlend2D

class BLFontUnicodeCoverageTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLFontUnicodeCoverage(data: (0, 1, 2, 3)),
            BLFontUnicodeCoverage(data: (0, 1, 2, 3))
        )
        
        XCTAssertNotEqual(
            BLFontUnicodeCoverage(data: (9, 1, 2, 3)),
            BLFontUnicodeCoverage(data: (0, 1, 2, 3))
        )
        
        XCTAssertNotEqual(
            BLFontUnicodeCoverage(data: (0, 9, 2, 3)),
            BLFontUnicodeCoverage(data: (0, 1, 2, 3))
        )
        
        XCTAssertNotEqual(
            BLFontUnicodeCoverage(data: (0, 1, 9, 3)),
            BLFontUnicodeCoverage(data: (0, 1, 2, 3))
        )
        
        XCTAssertNotEqual(
            BLFontUnicodeCoverage(data: (0, 1, 2, 9)),
            BLFontUnicodeCoverage(data: (0, 1, 2, 3))
        )
    }
}
