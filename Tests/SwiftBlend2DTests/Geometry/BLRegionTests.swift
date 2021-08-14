import XCTest
import blend2d
import SwiftBlend2D

class BLRegionTests: XCTestCase {
    func testRegionScan() {
        var region = BLRegion()
        region.combine(box: BLBoxI(x: 0, y: 0, w: 100, h: 100), operation: .or)
        region.combine(box: BLBoxI(x: 200, y: 200, w: 100, h: 100), operation: .or)
        
        XCTAssertEqual(
            region.regionScans, [
                BLBoxI(x: 0, y: 0, w: 100, h: 100),
                BLBoxI(x: 200, y: 200, w: 100, h: 100)
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

    func testArbitraryBoxesCrash() {
        var region = BLRegion()
        region.combine(box: BLBoxI(x0: 20, y0: 50, x1: 260, y1: 270), operation: .or)
        region.combine(box: BLBoxI(x0: -56, y0: -169, x1: 185, y1: 52), operation: .or)
        region.combine(box: BLBoxI(x0: -56, y0: -169, x1: 185, y1: 52), operation: .or)
        region.combine(box: BLBoxI(x0: -56, y0: -169, x1: 185, y1: 52), operation: .or)
        region.combine(box: BLBoxI(x0: -46, y0: -134, x1: 29, y1: -118), operation: .or)

        XCTAssertEqual(
            region.regionScans, [
                BLBoxI(x0: -56, y0: -169, x1: 185, y1: 50),
                BLBoxI(x0: -56, y0: 50, x1: 260, y1: 270)
            ]
        )
    }
    
    func testIsRegionValidAssertionCrash() {
        var region = BLRegion()
        region.combine(box: BLBoxI(x0: 174, y0: 92, x1: 506, y1: 463), operation: .or)
        region.combine(box: BLBoxI(x0: 189, y0: 466, x1: 482, y1: 478), operation: .or)
        region.combine(box: BLBoxI(x0: 189, y0: 478, x1: 482, y1: 484), operation: .or)
        region.combine(box: BLBoxI(x0: 189, y0: 440, x1: 482, y1: 446), operation: .or)
        
        XCTAssertEqual(region.regionScans, [
            BLBoxI(x0: 174, y0: 92, x1: 506, y1: 463),
            BLBoxI(x0: 189, y0: 466, x1: 482, y1: 484)
        ])
    }
}
