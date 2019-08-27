import XCTest
import blend2d
import SwiftBlend2D

class EnumsTestsTests: XCTestCase {
    
    func testOptionSetConformance() {
        isOptionSet(BLImageCodecFeatures.self)
        isOptionSet(BLPathFlags.self)
        isOptionSet(BLContextCreateFlags.self)
        isOptionSet(BLContextFlushFlags.self)
        isOptionSet(BLGlyphRunFlags.self)
        isOptionSet(BLGlyphItemFlags.self)
        isOptionSet(BLFontFaceFlags.self)
        isOptionSet(BLFontFaceDiagFlags.self)
        isOptionSet(BLFormatFlags.self)
        isOptionSet(BLFileOpenFlags.self)
        isOptionSet(BLFileReadFlags.self)
    }

    func isOptionSet<T: OptionSet>(_ value: T.Type) { }
}
