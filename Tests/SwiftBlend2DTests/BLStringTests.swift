import XCTest
import blend2d
@testable import SwiftBlend2D

class BLStringTests: XCTestCase {
    func testInit() {
        let string = BLString()
        
        XCTAssertEqual(string.size, 0)
        XCTAssert(string.toString().isEmpty)
    }
    
    func testInitWithString() {
        let string = BLString(string: "abc")
        
        XCTAssertEqual(string.size, 3)
        XCTAssertEqual(string.toString(), "abc")
    }
    
    func testAppendString() {
        let string = BLString(string: "abc")
        
        string += "def"
        
        XCTAssertEqual(string.size, 6)
        XCTAssertEqual(string.toString(), "abcdef")
    }
    
    func testCreateWithStringLiteral() {
        let string: BLString = "abc"
        
        XCTAssertEqual(string.size, 3)
        XCTAssertEqual(string.toString(), "abc")
    }
}
