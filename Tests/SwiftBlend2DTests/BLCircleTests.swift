import XCTest
import blend2d
@testable import SwiftBlend2D

class BLCircleTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLCircle(cx: 1, cy: 2, radius: 3),
                       BLCircle(cx: 1, cy: 2, radius: 3))
        
        XCTAssertNotEqual(BLCircle(cx: 9, cy: 2, radius: 3),
                          BLCircle(cx: 1, cy: 2, radius: 3))
        XCTAssertNotEqual(BLCircle(cx: 1, cy: 9, radius: 3),
                          BLCircle(cx: 1, cy: 2, radius: 3))
        XCTAssertNotEqual(BLCircle(cx: 1, cy: 2, radius: 9),
                          BLCircle(cx: 1, cy: 2, radius: 3))
    }
    
    func testInitWithCoordinates() {
        let circle = BLCircle(cx: 1, cy: 2, radius: 3)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.r, 3)
    }
    
    func testInitWithPoint() {
        let circle = BLCircle(center: BLPoint(x: 1, y: 2), radius: 3)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.r, 3)
    }
}
