import XCTest
import SwiftBlend2D

class BLFontMatrixTests: XCTestCase {
    func testMapRect() {
        let fontMatrix = BLFontMatrix(.init(m: (2, 0, 0, 3)))
        
        let result = fontMatrix.mapRect(BLRect(x: 5, y: 5, w: 10, h: 10))
        
        XCTAssertEqual(result.x, 10)
        XCTAssertEqual(result.y, 15)
        XCTAssertEqual(result.w, 20)
        XCTAssertEqual(result.h, 30)
    }
    
    func testMapBox() {
        let fontMatrix = BLFontMatrix(.init(m: (2, 0, 0, 3)))
        
        let result = fontMatrix.mapBox(BLBox(x: 5, y: 5, w: 10, h: 10))
        
        XCTAssertEqual(result.x0, 10)
        XCTAssertEqual(result.y0, 15)
        XCTAssertEqual(result.x1, 30)
        XCTAssertEqual(result.y1, 45)
    }
}
