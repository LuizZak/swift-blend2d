import XCTest

@testable import SwiftBlend2D

class BLFontFeatureSettingsTests: XCTestCase {
    func testItems() throws {
        let fontFace = try BLFontFace(fromFile: pathToTestFontFace())
        let font = BLFont(fromFace: fontFace, size: 12)

        let sut = font.features

        XCTAssertEqual(sut.items.count, 0)
    }
}
