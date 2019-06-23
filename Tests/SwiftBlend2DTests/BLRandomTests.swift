import XCTest
import blend2d
import SwiftBlend2D

class BLRandomTests: XCTestCase {
    func testEquals() {
        XCTAssertEqual(BLRandom(seed: 123), BLRandom(seed: 123))
        XCTAssertNotEqual(BLRandom(seed: 9), BLRandom(seed: 123))
    }
    
    func testReset() {
        var sut = BLRandom()
        
        sut.reset(seed: 123)
        let double1 = sut.nextDouble()
        sut.reset(seed: 123)
        let double2 = sut.nextDouble()
        
        XCTAssertEqual(double1, double2)
    }
}
