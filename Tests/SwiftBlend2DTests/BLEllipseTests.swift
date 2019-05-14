import XCTest
import blend2d
@testable import SwiftBlend2D

class BLEllipseTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4),
                       BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        
        XCTAssertNotEqual(BLEllipse(cx: 9, cy: 2, rx: 3, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 9, rx: 3, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 9, ry: 4),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
        XCTAssertNotEqual(BLEllipse(cx: 1, cy: 2, rx: 3, ry: 9),
                          BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4))
    }
    
    func testInitWithCoordinates() {
        let circle = BLEllipse(cx: 1, cy: 2, rx: 3, ry: 4)
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.rx, 3)
        XCTAssertEqual(circle.ry, 4)
    }
    
    func testInitWithPoint() {
        let circle = BLEllipse(center: BLPoint(x: 1, y: 2), radius: BLPoint(x: 3, y: 4))
        
        XCTAssertEqual(circle.cx, 1)
        XCTAssertEqual(circle.cy, 2)
        XCTAssertEqual(circle.rx, 3)
        XCTAssertEqual(circle.ry, 4)
    }

    func testInset() {
        let ellipse = BLEllipse(cx: 0, cy: 0, rx: 10, ry: 10)
        let result = ellipse.insetBy(x: 2, y: 2)

        XCTAssertEqual(result.cx, 1)
        XCTAssertEqual(result.cy, 1)
        XCTAssertEqual(result.rx, 8)
        XCTAssertEqual(result.ry, 8)
    }
}
