import XCTest
import blend2d
import SwiftBlend2D

class BLRuntimeSystemInfoTests: XCTestCase {
    func testCurrent() {
        // Just sanity check that we can get this value from the runtime
        let info = BLRuntimeSystemInfo.current

        XCTAssertNotEqual(info.cpu_features, 0)
    }
}
