import XCTest
import blend2d
@testable import SwiftBlend2D

class BLContextTests: XCTestCase {
    func testInit() {
        _ = BLContext()
    }
    
    func testInitWithImage() {
        let image = BLImage(width: 32, height: 32, format: BL_FORMAT_PRGB32)
        
        XCTAssertNotNil(BLContext(image: image))
    }
    
    func testInitWithImageReturnsNilOnEmptyImage() {
        let image = BLImage()
        
        XCTAssertNil(BLContext(image: image))
    }
}
