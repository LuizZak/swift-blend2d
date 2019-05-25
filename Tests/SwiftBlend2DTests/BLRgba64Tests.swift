import XCTest
import blend2d
import SwiftBlend2D

class BLRgba64Tests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRgba64(r: 1, g: 2, b: 3, a: 4),
                       BLRgba64(r: 1, g: 2, b: 3, a: 4))
        
        XCTAssertNotEqual(BLRgba64(r: 9, g: 2, b: 3, a: 4),
                          BLRgba64(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba64(r: 1, g: 9, b: 3, a: 4),
                          BLRgba64(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba64(r: 1, g: 2, b: 9, a: 4),
                          BLRgba64(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba64(r: 1, g: 2, b: 3, a: 9),
                          BLRgba64(r: 1, g: 2, b: 3, a: 4))
    }
    
    func testInitWithChannels() {
        let color = BLRgba64(r: 1, g: 2, b: 3, a: 4)
        
        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 4)
    }
    
    func testInitWithValue() {
        let color = BLRgba64(argb: (4 << 48) | (1 << 32) | (2 << 16) | (3))
        
        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 4)
    }
    
    func testInitWithRgba32() {
        let color = BLRgba64(BLRgba32(argb: (4 << 24) | (1 << 16) | (2 << 8) | (3)))
        
        // Basically increase resolution by 256 times (from 2-bytes 0xff to
        // 4-bytes 0xffff storage)
        XCTAssertEqual(color.r, 257)
        XCTAssertEqual(color.g, 514)
        XCTAssertEqual(color.b, 771)
        XCTAssertEqual(color.a, 1028)
    }
}
