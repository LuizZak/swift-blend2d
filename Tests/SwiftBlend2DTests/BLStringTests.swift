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
        
        string += "defgh" as String
        
        // TODO: Fix this (probably a memory corruption issue)
//        XCTAssertEqual(string.size, 8)
        XCTAssertEqual(string.toString(), "abcdefgh")
    }
    
    func testAppendBLString() {
        let string = BLString(string: "abc")
        
        string += "defgh" as BLString
        
        XCTAssertEqual(string.size, 8)
        XCTAssertEqual(string.toString(), "abcdefgh")
    }
    
    func testCreateWithStringLiteral() {
        let string: BLString = "abc"
        
        XCTAssertEqual(string.size, 3)
        XCTAssertEqual(string.toString(), "abc")
    }
    
    func testEquals() {
        XCTAssertEqual("" as BLString, "" as BLString)
        XCTAssertEqual("abc" as BLString, "abc" as BLString)
        XCTAssertNotEqual("abc" as BLString, "def" as BLString)
    }
}
