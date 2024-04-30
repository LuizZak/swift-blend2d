import XCTest
import blend2d
import SwiftBlend2D

class BLFormatInfoTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            ),
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            )
        )
        
        XCTAssertNotEqual(
            BLFormatInfo(
                depth: 9,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            ),
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            )
        )
        
        XCTAssertNotEqual(
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            ),
            BLFormatInfo(
                depth: 0,
                flags: .byteAligned,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            )
        )
        
        XCTAssertNotEqual(
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (9, 9, 9, 9), shifts: (9, 9, 9, 9)))
            ),
            BLFormatInfo(
                depth: 0,
                flags: .alpha,
                .init(.init(sizes: (2, 3, 4, 5), shifts: (6, 7, 8, 9)))
            )
        )
    }

    /* FIXME: Changes made to blFormatInfo[] invalidated static getters. See FIXME in BLFormatInfo.swift for more information.
    func testFormats() {
        XCTAssertEqual(BLFormatInfo.none, blFormatInfo.0)
        XCTAssertEqual(BLFormatInfo.prgb32, blFormatInfo.1)
        XCTAssertEqual(BLFormatInfo.xrgb32, blFormatInfo.2)
        XCTAssertEqual(BLFormatInfo.a8, blFormatInfo.3)
    }
    
    func testInitQuery() {
        XCTAssertNil(BLFormatInfo(query: .none))
        XCTAssertEqual(BLFormatInfo(query: .a8), BLFormatInfo.a8)
        XCTAssertEqual(BLFormatInfo(query: .prgb32), BLFormatInfo.prgb32)
        XCTAssertEqual(BLFormatInfo(query: .xrgb32), BLFormatInfo.xrgb32)
    }
    
    func testSanitize() throws {
        var format = BLFormatInfo.a8
        try format.sanitize()
        
        var invalidFormat = BLFormatInfo()
        
        XCTAssertThrowsError(try invalidFormat.sanitize())
    }
    */
}
