import XCTest
import blend2d
@testable import SwiftBlend2D

class BLBaseClassTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        MockStructure.latestInitializer = nil
        MockStructure.latestDeinitializer = nil
    }
    
    func testDefaultInitialize() {
        let sut = BLBaseClass<MockStructure>()
        
        XCTAssertEqual(sut.ownership, .owner)
        XCTAssertNotNil(MockStructure.latestInitializer)
        XCTAssertEqual(MockStructure.latestInitializer, makePointer(&sut.object))
    }
    
    func testInitializeWithClosure() {
        var pointer: UnsafeMutablePointer<MockStructure>?
        _ = BLBaseClass<MockStructure> { p -> BLResult in
            pointer = p
            return BL_SUCCESS.rawValue
        }
        
        XCTAssertNotNil(pointer)
        XCTAssertNil(MockStructure.latestInitializer)
    }
    
    func testDeinitialize() {
        let sut = BLBaseClass<MockStructure>()
        
        withExtendedLifetime(sut) {
            sut.deinitialize()
            
            XCTAssertEqual(MockStructure.latestDeinitializer, makePointer(&sut.object))
        }
    }
    
    func testDeinitializeWithBorrowedObject() {
        let sut = BLBaseClass<MockStructure>(borrowing: MockStructure())
        
        withExtendedLifetime(sut) {
            sut.deinitialize()
            
            XCTAssertNil(MockStructure.latestDeinitializer)
        }
    }
    
    func testDeinitializeOnLeaveScope() {
        #if canImport(ObjectiveC)
        autoreleasepool {
            _ = BLBaseClass<MockStructure>()
        }
        
        XCTAssertNotNil(MockStructure.latestDeinitializer)
        #endif
    }
    
    func testBorrowInitializer() {
        let sut = BLBaseClass<MockStructure>(borrowing: MockStructure())
        
        XCTAssertEqual(sut.ownership, .borrowed)
    }
    
    func testDontDeinitializeBorrowedObjects() {
        #if canImport(ObjectiveC)
        autoreleasepool {
            _ = BLBaseClass<MockStructure>(borrowing: MockStructure())
        }
        
        XCTAssertNil(MockStructure.latestDeinitializer)
        #endif
    }
}

private func makePointer<T>(_ object: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<T> {
    return object
}

private struct MockStructure: CoreStructure {
    static var latestInitializer: UnsafeMutablePointer<MockStructure>?
    static var latestDeinitializer: UnsafeMutablePointer<MockStructure>?
    
    static var initializer: (UnsafeMutablePointer<MockStructure>?) -> BLResult = {
        latestInitializer = $0
        return BL_SUCCESS.rawValue
    }
    
    static var deinitializer: (UnsafeMutablePointer<MockStructure>?) -> BLResult = {
        latestDeinitializer = $0
        return BL_SUCCESS.rawValue
    }
}
