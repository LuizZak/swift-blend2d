import XCTest
import blend2d
import SwiftBlend2D

class BLRuntimeMemoryInfoTests: XCTestCase {
    func testCurrent() {
        // Just sanity check that we can get this value from the runtime
        _ = BLRuntimeMemoryInfo.current
    }
}

