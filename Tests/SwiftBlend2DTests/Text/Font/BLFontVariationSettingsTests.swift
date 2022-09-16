import XCTest

@testable import SwiftBlend2D

class BLFontVariationSettingsTests: XCTestCase {
    func testItems() throws {
        let fontFace = try BLFontFace(fromFile: pathToTestFontFace())
        let font = BLFont(fromFace: fontFace, size: 12)

        let sut = font.variations

        XCTAssertEqual(sut.items.count, 0)
    }
}
