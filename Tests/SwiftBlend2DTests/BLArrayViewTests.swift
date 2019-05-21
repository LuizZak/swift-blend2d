import XCTest
import blend2d
@testable import SwiftBlend2D

class BLArrayViewTests: XCTestCase {
    func testWithTemporaryView() {
        let array: [Double] = [1.0, 2.0, 3.0]
        
        array.withTemporaryView { view in
            XCTAssertNotNil(view.pointee.data)
            XCTAssertEqual(view.pointee.size, 3)
        }
    }
    
    func testWithTemporaryViewWithEmptyArray() {
        let array: [Double] = []
        
        array.withTemporaryView { view in
            XCTAssertNotNil(view.pointee.data)
            XCTAssertEqual(view.pointee.size, 0) // = MemoryLayout<Double>.stride * array.count
        }
    }
}
