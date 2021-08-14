import XCTest
import blend2d
import SwiftBlend2D

class BLPathTests: XCTestCase {
    func testFigureRanges() {
        let path = BLPath()
        path.moveTo(x: 10, y: 10)
        path.lineTo(x: 20, y: 10)
        path.lineTo(x: 20, y: 20)
        path.lineTo(x: 10, y: 20)
        path.moveTo(x: 30, y: 30)
        path.lineTo(x: 40, y: 30)
        path.lineTo(x: 40, y: 40)
        path.lineTo(x: 30, y: 40)

        XCTAssertEqual(path.figureRanges, [
            BLRange(start: 0, end: 4),
            BLRange(start: 4, end: 8)
        ])
    }

    func testFigureRangesWithClose() {
        let path = BLPath()
        path.moveTo(x: 10, y: 10)
        path.lineTo(x: 20, y: 10)
        path.lineTo(x: 20, y: 20)
        path.lineTo(x: 10, y: 20)
        path.close()
        path.moveTo(x: 30, y: 30)
        path.lineTo(x: 40, y: 30)
        path.lineTo(x: 40, y: 40)
        path.lineTo(x: 30, y: 40)

        XCTAssertEqual(path.figureRanges, [
            BLRange(start: 0, end: 5),
            BLRange(start: 5, end: 9)
        ])
    }
    
    func testEquatePathToItselfDoesNotTriggerExclusiveAccessCrash() {
        let path = BLPath()
        
        XCTAssertEqual(path, path)
    }
}
