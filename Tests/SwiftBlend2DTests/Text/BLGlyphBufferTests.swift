import XCTest
import blend2d
import SwiftBlend2D

class BLGlyphBufferTests: XCTestCase {
    func testGlyphIds_alphabet() {
        let sut = BLGlyphBuffer(text: "abcdefghijklmnopqrstuvwxyz")

        XCTAssertEqual(sut.glyphIds, [
            97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
            111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122
        ])
    }

    func testGlyphIds_diacritic() {
        let sut = BLGlyphBuffer(text: "éáËã")

        XCTAssertEqual(sut.glyphIds, [233, 225, 203, 227])
    }

    func testGlyphIds_specialCharacters() {
        let sut = BLGlyphBuffer(text: "•")

        XCTAssertEqual(sut.glyphIds, [8226])
    }

    func testGlyphIds_emojis() {
        let sut = BLGlyphBuffer(text: "🚀🎉")

        XCTAssertEqual(sut.glyphIds, [0x1F680, 0x1F389])
    }

    func testGlyphIds_emojis_zwj() {
        let sut = BLGlyphBuffer(text: "👁️‍🗨️")

        XCTAssertEqual(sut.glyphIds, [
            0x1F441, // Eye emoji
            0xFE0F, // Variation selector
            0x200D, // Zero-width joiner
            0x1F5E8, // Left speech bubble emoji
            0xFE0F, // Variation selector
        ])
    }
}
