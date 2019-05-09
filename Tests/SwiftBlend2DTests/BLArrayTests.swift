import XCTest
import blend2d
@testable import SwiftBlend2D

class BLArrayTests: XCTestCase {
    func testInit() {
        let sut = BLArray(type: BL_IMPL_TYPE_ARRAY_U8)
        
        XCTAssertEqual(sut.count, 0)
    }
    
    func testAppendU8() {
        let sut = BLArray(type: BL_IMPL_TYPE_ARRAY_U8)
        
        sut.append(0 as UInt8)
        
        XCTAssertEqual(sut.count, 1)
    }
    
    func testReserveCapacity() {
        let sut = BLArray(type: BL_IMPL_TYPE_ARRAY_U8)
        
        sut.reserveCapacity(16)
        
        XCTAssert(sut.capacity >= 16)
    }
    
    func testShrink() {
        let sut = BLArray(type: BL_IMPL_TYPE_ARRAY_U8)
        sut.reserveCapacity(128)
        sut.append(0 as UInt8)
        sut.append(1 as UInt8)
        sut.append(2 as UInt8)
        
        sut.shrink()
        
        XCTAssertEqual(sut.count, 3)
        XCTAssert(sut.capacity <= 32)
    }
    
    func testWithTemporaryArrayViewForDouble() {
        BLArray.withTemporaryArrayView(for: [0, 1, 2]) { pointer, size in
            XCTAssertNotNil(pointer)
            XCTAssertEqual(size, 24) // = MemoryLayout<Double>.size * array.count
        }
    }
    
    func testWithTemporaryArrayViewForDoubleWithEmptyArray() {
        BLArray.withTemporaryArrayView(for: []) { pointer, size in
            XCTAssertNotNil(pointer)
            XCTAssertEqual(size, 0) // = MemoryLayout<Double>.size * array.count
        }
    }
    
    func testWeakAssign() {
        let array = BLArray(type: .arrayOfInt32)
        // Append an item to force creation of a new backing array structure
        array.append(1 as Int32)
        
        do {
            let weak = BLArray(weakAssign: array.object)
            withExtendedLifetime(weak) {
                XCTAssertEqual(array.object.impl.pointee.refCount, 2)
            }
        }
        
        XCTAssertEqual(array.object.impl.pointee.refCount, 1)
    }
}
