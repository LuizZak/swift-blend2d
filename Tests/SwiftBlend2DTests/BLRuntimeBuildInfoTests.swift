import XCTest
import blend2d
import SwiftBlend2D

class BLRuntimeBuildInfoTests: XCTestCase {
    func testCurrent() {
        // Just sanity check that we can get this value from the runtime
        let info = BLRuntimeBuildInfo.current
        
        XCTAssertEqual(info.maxImageSize, BL_RUNTIME_MAX_IMAGE_SIZE.rawValue)
    }
}
