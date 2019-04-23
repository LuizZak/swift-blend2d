import XCTest
import blend2d
import SwiftBlend2D

class StructuresTests: XCTestCase {
    
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
    }
    
    // If this invocation fails, T does not conform to OptionSet.
    func isOptionSet<T: OptionSet>(_ value: T.Type) { }
}
