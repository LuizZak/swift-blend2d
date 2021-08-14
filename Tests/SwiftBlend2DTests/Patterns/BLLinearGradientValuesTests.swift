import XCTest
import blend2d
import SwiftBlend2D

class BLLinearGradientValuesTests: XCTestCase {
    func testInitWithBox() {
        let box = BLBox(x0: 1, y0: 2, x1: 3, y1: 4)
        let values = BLLinearGradientValues(box: box)
        
        XCTAssertEqual(values.x0, box.x0)
        XCTAssertEqual(values.y0, box.y0)
        XCTAssertEqual(values.x1, box.x1)
        XCTAssertEqual(values.y1, box.y1)
    }
    
    func testInitWithPoints() {
        let start = BLPoint(x: 1, y: 2)
        let end = BLPoint(x: 3, y: 4)
        let values = BLLinearGradientValues(start: start, end: end)
        
        XCTAssertEqual(values.x0, start.x)
        XCTAssertEqual(values.y0, start.y)
        XCTAssertEqual(values.x1, end.x)
        XCTAssertEqual(values.y1, end.y)
    }
    
    func testInitWithLine() {
        let line = BLLine(x0: 1, y0: 2, x1: 3, y1: 4)
        let values = BLLinearGradientValues(line: line)
        
        XCTAssertEqual(values.x0, line.x0)
        XCTAssertEqual(values.y0, line.y0)
        XCTAssertEqual(values.x1, line.x1)
        XCTAssertEqual(values.y1, line.y1)
    }
}
