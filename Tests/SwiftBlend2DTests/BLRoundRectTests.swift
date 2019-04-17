import XCTest
import blend2d
@testable import SwiftBlend2D

class BLRoundRectTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)),
                       BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 9, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 9, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 9, h: 3), radius: BLPoint(x: 4, y: 5)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 9), radius: BLPoint(x: 4, y: 5)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 9, y: 5)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 9)),
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)))
    }
    
    func testInitWithRectAndPoint() {
        let sut = BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5))
        
        XCTAssertEqual(sut.x, 0)
        XCTAssertEqual(sut.y, 1)
        XCTAssertEqual(sut.w, 2)
        XCTAssertEqual(sut.h, 3)
        XCTAssertEqual(sut.rx, 4)
        XCTAssertEqual(sut.ry, 5)
    }
}
