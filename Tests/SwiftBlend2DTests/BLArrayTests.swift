import XCTest
import blend2d
@testable import SwiftBlend2D

class BLArrayTests: XCTestCase {
    func testInit() {
        let sut = BLArray<UInt8>()
        
        XCTAssertEqual(sut.count, 0)
    }
    
    func testAppendU8() {
        let sut = BLArray<UInt8>()
        
        sut.append(0 as UInt8)
        
        XCTAssertEqual(sut.count, 1)
    }
    
    func testReserveCapacity() {
        let sut = BLArray<UInt8>()
        
        sut.reserveCapacity(16)
        
        XCTAssert(sut.capacity >= 16)
    }
    
    func testShrink() {
        let sut = BLArray<UInt8>()
        sut.reserveCapacity(128)
        sut.append(0 as UInt8)
        sut.append(1 as UInt8)
        sut.append(2 as UInt8)
        
        sut.shrink()
        
        XCTAssertEqual(sut.count, 3)
        XCTAssert(sut.capacity <= 32)
    }
    
    func testWeakAssign() {
        let array = BLArray<Int32>()
        // Append an item to force creation of a new backing array structure
        array.append(1 as Int32)
        
        do {
            let weak = BLArray<Int32>(weakAssign: array.object)
            withExtendedLifetime(weak) {
                XCTAssertEqual(array.object.impl.pointee.refCount, 2)
            }
        }
        
        XCTAssertEqual(array.object.impl.pointee.refCount, 1)
    }
    
    func testInitWithArray() {
        let array = BLArray<Int>(array: [1, 2, 3])
        
        XCTAssertEqual(array.count, 3)
    }
    
    func testSubscript() {
        let array = BLArray<Int>(array: [1, 2, 3])
        
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[1], 2)
        XCTAssertEqual(array[2], 3)
    }
}
