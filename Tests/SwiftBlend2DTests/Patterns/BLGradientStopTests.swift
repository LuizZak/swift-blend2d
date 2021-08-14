import XCTest
import blend2d
import SwiftBlend2D

class BLGradientStopTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLGradientStop(offset: 0, rgba: BLRgba64(argb: 0xffffeeeeddddcccc)),
                       BLGradientStop(offset: 0, rgba: BLRgba64(argb: 0xffffeeeeddddcccc)))
        
        XCTAssertNotEqual(BLGradientStop(offset: 9, rgba: BLRgba64(argb: 0xffffeeeeddddcccc)),
                          BLGradientStop(offset: 0, rgba: BLRgba64(argb: 0xffffeeeeddddcccc)))
        XCTAssertNotEqual(BLGradientStop(offset: 0, rgba: BLRgba64(argb: 0x9999999999999999)),
                          BLGradientStop(offset: 0, rgba: BLRgba64(argb: 0xffffeeeeddddcccc)))
    }
    
    func testInitWithRgba32() {
        let color = BLRgba32(argb: 0xffeeddcc)
        let stop = BLGradientStop(offset: 0, rgba: color)
        
        XCTAssertEqual(stop.rgba.r, 0xeeee)
        XCTAssertEqual(stop.rgba.g, 0xdddd)
        XCTAssertEqual(stop.rgba.b, 0xcccc)
        XCTAssertEqual(stop.rgba.a, 0xffff)
    }
}
