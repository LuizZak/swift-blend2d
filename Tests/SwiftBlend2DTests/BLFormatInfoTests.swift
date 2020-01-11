import XCTest
import blend2d
import SwiftBlend2D

class BLFormatInfoTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))),
                       BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))))
        
        XCTAssertNotEqual(BLFormatInfo(depth: 9, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))),
                          BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))))
        
        XCTAssertNotEqual(BLFormatInfo(depth: 0, flags: 9, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))),
                          BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))))
        
        XCTAssertNotEqual(BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (9, 9, 9, 9), shifts: (9, 9, 9, 9)))),
                          BLFormatInfo(depth: 0, flags: 1, .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))))
    }
    
    func testFormats() {
        XCTAssertEqual(BLFormatInfo.none, blFormatInfo.0)
        XCTAssertEqual(BLFormatInfo.prgb32, blFormatInfo.1)
        XCTAssertEqual(BLFormatInfo.xrgb32, blFormatInfo.2)
        XCTAssertEqual(BLFormatInfo.a8, blFormatInfo.3)
    }
}
