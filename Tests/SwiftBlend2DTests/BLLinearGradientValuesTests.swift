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
}
