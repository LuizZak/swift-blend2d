import XCTest

@testable import SwiftBlend2D

class BLBitSetTests: XCTestCase {
    func testMakeIterator() {
        let bitSet = BLBitSet()
        bitSet.addRange(startBit: 100, endBit: 200)
        
        let result = Array(bitSet)

        XCTAssertEqual(result, [
            0x0FFFFFFF,
            0xFFFFFFFF,
            0xFFFFFFFF,
            0xFF000000,
        ])
    }
}
