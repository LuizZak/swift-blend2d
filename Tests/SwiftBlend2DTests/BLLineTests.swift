import XCTest
import blend2d
@testable import SwiftBlend2D

class BLLineTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLLine(startX: 0, startY: 1, endX: 2, endY: 3),
                       BLLine(startX: 0, startY: 1, endX: 2, endY: 3))
        
        XCTAssertNotEqual(BLLine(startX: 1, startY: 1, endX: 2, endY: 3),
                          BLLine(startX: 0, startY: 1, endX: 2, endY: 3))
        XCTAssertNotEqual(BLLine(startX: 0, startY: 2, endX: 2, endY: 3),
                          BLLine(startX: 0, startY: 1, endX: 2, endY: 3))
        XCTAssertNotEqual(BLLine(startX: 0, startY: 1, endX: 3, endY: 3),
                          BLLine(startX: 0, startY: 1, endX: 2, endY: 3))
        XCTAssertNotEqual(BLLine(startX: 0, startY: 1, endX: 2, endY: 4),
                          BLLine(startX: 0, startY: 1, endX: 2, endY: 3))
    }
    
    func testInitWithPoints() {
        let line = BLLine(start: BLPoint(x: 0, y: 1), end: BLPoint(x: 2, y: 3))
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }
    
    func testInitWithCoordinates() {
        let line = BLLine(startX: 0, startY: 1, endX: 2, endY: 3)
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }
}
