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
    
    func testDeinitializeWithWeaklyAssignedObject() {
        let sut = BLBaseClass<MockStructure>(weakAssign: MockStructure())
        
        withExtendedLifetime(sut) {
            sut.deinitialize()
            
            XCTAssertNotNil(MockStructure.latestDeinitializer)
        }
    }
    
    func testDeinitializeOnLeaveScope() {
        do {
            _ = BLBaseClass<MockStructure>()
        }
        
        XCTAssertNotNil(MockStructure.latestDeinitializer)
    }
    
    func testWeakAssignInitializer() {
        let sut = BLBaseClass<MockStructure>(weakAssign: MockStructure())
        
        withUnsafePointer(to: &sut.object) { pointer in
            XCTAssertNotNil(MockStructure.latestAssignWeak)
        }
    }
    
    func testDeinitializeWeaklyAssignedObjects() {
        do {
            _ = BLBaseClass<MockStructure>(weakAssign: MockStructure())
        }
        
        XCTAssertNotNil(MockStructure.latestDeinitializer)
    }
}

private func makePointer<T>(_ object: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<T> {
    return object
}

private final class MockStructure: CoreStructure {
    static var latestInitializer: UnsafeMutablePointer<MockStructure>?
    static var latestDeinitializer: UnsafeMutablePointer<MockStructure>?
    static var latestAssignWeak: (UnsafeMutablePointer<MockStructure>?, UnsafePointer<MockStructure>?)?
    
    static var initializer: (UnsafeMutablePointer<MockStructure>?) -> BLResult = {
        latestInitializer = $0
        return BL_SUCCESS.rawValue
    }
    
    static var deinitializer: (UnsafeMutablePointer<MockStructure>?) -> BLResult = {
        latestDeinitializer = $0
        return BL_SUCCESS.rawValue
    }
    
    static var assignWeak: (UnsafeMutablePointer<MockStructure>?, UnsafePointer<MockStructure>?) -> BLResult = {
        latestAssignWeak = ($0, $1)
        return BL_SUCCESS.rawValue
    }
}
