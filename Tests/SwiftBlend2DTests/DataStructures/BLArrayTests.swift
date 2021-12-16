import XCTest
import blend2d
@testable import SwiftBlend2D

class BLArrayTests: XCTestCase {
    func testInit() {
        let sut = BLArray<UInt8>()
        
        XCTAssertEqual(sut.count, 0)
    }
    
    func testIsEmpty() {
        let sut = BLArray<Int>()
        
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testIsEmpty_nonEmptyArray_returnsFalse() {
        let sut = BLArray<Int>()
        sut.append(0)
        
        XCTAssertFalse(sut.isEmpty)
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
        sut.append(0)
        sut.append(1)
        sut.append(2)
        
        sut.shrink()
        
        XCTAssertEqual(sut.count, 3)
        XCTAssert(sut.capacity <= 32)
    }
    
    /*
    func testWeakAssign() {
        let array = BLArray<Int32>()
        // Append an item to force creation of a new backing array structure
        array.append(1)
        
        do {
            let weak = BLArray<Int32>(weakAssign: array.object)
            withExtendedLifetime(weak) {
                XCTAssertEqual(array.object.impl.refCount, 2)
            }
        }
        
        XCTAssertEqual(array.object.impl.refCount, 1)
    }
    */
    
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
    
    func testReplaceContents() {
        let array = BLArray<Int>(array: [1])
        
        array.replaceContents([2, 3, 4])
        
        XCTAssertEqual(array.count, 3)
        XCTAssertEqual(array[0], 2)
        XCTAssertEqual(array[1], 3)
        XCTAssertEqual(array[2], 4)
    }
    
    func testAsArray() {
        let array = BLArray<Int>(array: [0xDD, 0xEE, 0xFF])
        
        XCTAssertEqual(array.asArray(), [0xDD, 0xEE, 0xFF])
    }
    
    func testUnsafeAsArrayOf() {
        let array = BLArray<Int>(array: [0xFF])
        
        let result = array.unsafeAsArray(of: Int8.self)
        
        XCTAssertEqual(result, [-1])
    }
}
