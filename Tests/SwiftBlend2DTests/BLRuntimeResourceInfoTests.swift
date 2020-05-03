import XCTest
import blend2d
import SwiftBlend2D

class BLRuntimeResourceInfoTests: XCTestCase {
    func testCurrent() {
        // Just sanity check that we can get this value from the runtime
        _ = BLRuntimeResourceInfo.current
    }
}
