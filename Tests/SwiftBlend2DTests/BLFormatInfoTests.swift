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
}
