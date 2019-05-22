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
}
