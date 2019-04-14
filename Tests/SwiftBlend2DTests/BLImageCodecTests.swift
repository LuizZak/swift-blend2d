import XCTest
@testable import SwiftBlend2D

class BLImageCodecTests: XCTestCase {
    func testBuiltInCodecsCountMatchesInternalImageCodecs() {
        XCTAssertEqual(BLImageCodec.BuiltInImageCodec.allCases.count, BLImageCodec.builtInCodecs.count)
    }
    
    func testBuiltInCodecs() {
        for codec in BLImageCodec.BuiltInImageCodec.allCases {
            _ = BLImageCodec(builtInCodec: codec)
        }
    }
}
