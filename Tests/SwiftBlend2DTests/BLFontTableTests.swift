import XCTest
import blend2d
import SwiftBlend2D

class BLFontTableTests: XCTestCase {
    func testWithBufferPointer() {
        let size = 32
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        let fontTable = BLFontTable(data: buffer, size: size)
        
        fontTable.withBufferPointer { pointer in
            XCTAssertEqual(pointer.count, size)
        }
    }
}
