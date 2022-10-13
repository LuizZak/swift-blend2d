import XCTest
import blend2d
@testable import SwiftBlend2D

class BLGradientTests: XCTestCase {
    func testCopyOnWrite() {
        let linear = BLGradient(
            linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 10, y1: 10)
        )
        var copy = linear
        
        copy.setValue(.commonX0, 10)
        
        XCTAssertEqual(linear.values, [0, 0, 10, 10, 0, 0])
        XCTAssertEqual(copy.values, [10, 0, 10, 10, 0, 0])
    }
    
    func testCopyOnWriteInstanceReference() {
        let linear = BLGradient(
            linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 10, y1: 10)
        )
        var copy = linear
        
        XCTAssert(linear.box === copy.box)
        XCTAssert(linear.box.object._d.impl == copy.box.object._d.impl)
        
        copy.setValue(.commonX0, 10)
        
        XCTAssert(linear.box.object._d.impl != copy.box.object._d.impl)
    }

    func testSetGradientValues() {
        var gradient = BLGradient(
            linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 0, y1: 0)
        )

        gradient.gradientValues = .radial(
            BLRadialGradientValues(x0: 0, y0: 0, x1: 10, y1: 10, r0: 0)
        )

        XCTAssertEqual(gradient.type, .radial)
    }
}
