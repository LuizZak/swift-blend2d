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
    
    func testHashable() {
        XCTAssertEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue,
                       BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 9, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 9, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 9, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 9), radius: BLPoint(x: 4, y: 5)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 9, y: 5)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
        XCTAssertNotEqual(BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 9)).hashValue,
                          BLRoundRect(rect: BLRect(x: 0, y: 1, w: 2, h: 3), radius: BLPoint(x: 4, y: 5)).hashValue)
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

    func testInset() {
        let rect = BLRoundRect(x: 0, y: 0, w: 10, h: 10, rx: 2, ry: 2)
        let result = rect.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.x, 1)
        XCTAssertEqual(result.y, 1)
        XCTAssertEqual(result.w, 8)
        XCTAssertEqual(result.h, 8)
        XCTAssertEqual(result.rx, 2)
        XCTAssertEqual(result.ry, 2)
    }

    func testQuadrants() {
        let rect = BLRoundRect(x: 1, y: 2, w: 3, h: 4, rx: 2, ry: 2)

        XCTAssertEqual(rect.topLeft, BLPoint(x: 1, y: 2))
        XCTAssertEqual(rect.topRight, BLPoint(x: 4, y: 2))
        XCTAssertEqual(rect.bottomLeft, BLPoint(x: 1, y: 6))
        XCTAssertEqual(rect.bottomRight, BLPoint(x: 4, y: 6))
    }
    
    func testSides() {
        let rect = BLRoundRect(x: 1, y: 2, w: 3, h: 4, rx: 2, ry: 2)

        XCTAssertEqual(rect.top, 2)
        XCTAssertEqual(rect.right, 4)
        XCTAssertEqual(rect.left, 1)
        XCTAssertEqual(rect.bottom, 6)
    }

    func testSize() {
        var rect = BLRoundRect(x: 1, y: 2, w: 3, h: 4, rx: 5, ry: 6)

        XCTAssertEqual(rect.size, BLSize(w: 3, h: 4))

        rect.size = BLSize(w: 7, h: 8)

        XCTAssertEqual(rect.size, BLSize(w: 7, h: 8))
    }
    
    func testCenter() {
        var rect = BLRoundRect(x: 1, y: 2, w: 3, h: 4, rx: 2, ry: 2)

        XCTAssertEqual(rect.center, BLPoint(x: 2.5, y: 4))

        rect.center = BLPoint(x: 5, y: 6)

        XCTAssertEqual(rect, BLRoundRect(x: 3.5, y: 4, w: 3, h: 4, rx: 2, ry: 2))
    }
}
