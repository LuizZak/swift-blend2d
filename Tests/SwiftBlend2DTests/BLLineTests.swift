import XCTest
import blend2d
@testable import SwiftBlend2D

class BLLineTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 3),
                       BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        
        XCTAssertNotEqual(BLLine(x0: 1, y0: 1, x1: 2, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 2, x1: 2, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 3, y1: 3),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
        XCTAssertNotEqual(BLLine(x0: 0, y0: 1, x1: 2, y1: 4),
                          BLLine(x0: 0, y0: 1, x1: 2, y1: 3))
    }
    
    func testInitWithPoints() {
        let line = BLLine(start: BLPoint(x: 0, y: 1), end: BLPoint(x: 2, y: 3))
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }
    
    func testInitWithCoordinates() {
        let line = BLLine(x0: 0, y0: 1, x1: 2, y1: 3)
        
        XCTAssertEqual(line.x0, 0)
        XCTAssertEqual(line.y0, 1)
        XCTAssertEqual(line.x1, 2)
        XCTAssertEqual(line.y1, 3)
    }
}
