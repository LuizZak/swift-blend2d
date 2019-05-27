import XCTest
import blend2d
import SwiftBlend2D

class BLRegionTests: XCTestCase {
    func testRegionScan() {
        var region = BLRegion()
        region.combine(box: BLBoxI(x: 0, y: 0, width: 100, height: 100), operation: .or)
        region.combine(box: BLBoxI(x: 200, y: 200, width: 100, height: 100), operation: .or)
        
        XCTAssertEqual(
            region.regionScans, [
                BLBoxI(x: 0, y: 0, width: 100, height: 100),
                BLBoxI(x: 200, y: 200, width: 100, height: 100)
            ]
        )
    }

    func testSubtract() {
        var region = BLRegion()
        region.combine(box: BLBoxI(x0: 0, y0: 0, x1: 100, y1: 100), operation: .or)
        region.combine(box: BLBoxI(x0: 25, y0: 25, x1: 75, y1: 75), operation: .sub)

        XCTAssertEqual(
            region.regionScans, [
                BLBoxI(x0: 0, y0: 0, x1: 100, y1: 25),
                BLBoxI(x0: 0, y0: 25, x1: 25, y1: 75),
                BLBoxI(x0: 75, y0: 25, x1: 100, y1: 75),
                BLBoxI(x0: 0, y0: 75, x1: 100, y1: 100)
            ]
        )
    }
}
