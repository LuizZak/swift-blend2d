import XCTest
import blend2d
import SwiftBlend2D

class BLRgba32Tests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRgba32(r: 1, g: 2, b: 3, a: 4),
                       BLRgba32(r: 1, g: 2, b: 3, a: 4))
        
        XCTAssertNotEqual(BLRgba32(r: 9, g: 2, b: 3, a: 4),
                          BLRgba32(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba32(r: 1, g: 9, b: 3, a: 4),
                          BLRgba32(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba32(r: 1, g: 2, b: 9, a: 4),
                          BLRgba32(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNotEqual(BLRgba32(r: 1, g: 2, b: 3, a: 9),
                          BLRgba32(r: 1, g: 2, b: 3, a: 4))
    }
    
    func testInitWithChannels() {
        let color = BLRgba32(r: 1, g: 2, b: 3, a: 4)
        
        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 4)
    }
    
    func testInitWithValue() {
        let color = BLRgba32(argb: (4 << 24) | (1 << 16) | (2 << 8) | (3))
        
        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 4)
    }
    
    func testInitWithRgba64() {
        let color = BLRgba32(rgba64: BLRgba64(argb: (1028 << 48) | (257 << 32) | (514 << 16) | (771)))
        
        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 4)
    }

    func testWithTransparency() {
        let color = BLRgba32(r: 1, g: 2, b: 3, a: 4).withTransparency(10)

        XCTAssertEqual(color.r, 1)
        XCTAssertEqual(color.g, 2)
        XCTAssertEqual(color.b, 3)
        XCTAssertEqual(color.a, 10)
    }
}
