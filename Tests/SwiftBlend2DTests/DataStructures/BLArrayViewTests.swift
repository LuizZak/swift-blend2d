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
            XCTAssertEqual(view.pointee.size, 0)
        }
    }

    func testIterateArrayView() {
        let array = [1, 2, 3]

        array.withTemporaryView { view in
            let iterator = view.pointee.makeIterator()

            XCTAssertEqual(iterator.next(), 1)
            XCTAssertEqual(iterator.next(), 2)
            XCTAssertEqual(iterator.next(), 3)
            XCTAssertNil(iterator.next())
        }
    }
}
