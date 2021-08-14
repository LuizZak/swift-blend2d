import XCTest
import blend2d
import SwiftBlend2D

class BLGlyphBufferTests: XCTestCase {
    func testGlyphIds_Alphabet() {
        let sut = BLGlyphBuffer(text: "abcdefghijklmnopqrstuvwxyz")

        XCTAssertEqual(sut.glyphIds, [
            97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
            111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122
        ])
    }

    func testGlyphIds_Diacritic() {
        let sut = BLGlyphBuffer(text: "éáËã")

        XCTAssertEqual(sut.glyphIds, [233, 225, 203, 227])
    }

    func testGlyphIds_SpecialCharacters() {
        let sut = BLGlyphBuffer(text: "•")

        XCTAssertEqual(sut.glyphIds, [8226])
    }
}
