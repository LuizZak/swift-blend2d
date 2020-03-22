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
        var string = BLString(string: "abc")
        
        string += "defgh" as String
        
        XCTAssertEqual(string.size, 8)
        XCTAssertEqual(string.toString(), "abcdefgh")
    }
    
    func testAppendStringToEmptyString() {
        var string = BLString(string: "")
        
        string += "abcdefgh" as String
        
        XCTAssertEqual(string.size, 8)
        XCTAssertEqual(string.toString(), "abcdefgh")
    }
    
    func testAppendBLString() {
        var string = BLString(string: "abc")
        
        string += "defgh" as BLString
        
        XCTAssertEqual(string.size, 8)
        XCTAssertEqual(string.toString(), "abcdefgh")
    }
    
    func testAppendBLStringToEmptyString() {
        var string = BLString(string: "")
        
        string += "abcdefgh" as BLString
        
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
    
    func testSubscript() {
        let string = BLString(string: "abc")
        
        XCTAssertEqual(string[0], Int8(("a" as UnicodeScalar).value))
        XCTAssertEqual(string[1], Int8(("b" as UnicodeScalar).value))
        XCTAssertEqual(string[2], Int8(("c" as UnicodeScalar).value))
    }
    
    func testSequenceConformance() {
        let string = BLString(string: "abc")
        var iterator = string.makeIterator()
        
        XCTAssertEqual(iterator.next(), Int8(("a" as UnicodeScalar).value))
        XCTAssertEqual(iterator.next(), Int8(("b" as UnicodeScalar).value))
        XCTAssertEqual(iterator.next(), Int8(("c" as UnicodeScalar).value))
        XCTAssertNil(iterator.next())
    }
    
    func testCollectionConformance() {
        let string = BLString(string: "abc")
        
        XCTAssertEqual(string.startIndex, 0)
        XCTAssertEqual(string.endIndex, 3)
        XCTAssertEqual(string.index(after: 0), 1)
        XCTAssertEqual(string.index(after: 1), 2)
        XCTAssertEqual(string.index(after: 2), 3)
    }
    
    func testCopyOnWrite() {
        var string = BLString(string: "abc")
        let copy = string
        
        string += "def"
        
        XCTAssertEqual(string.toString(), "abcdef")
        XCTAssertEqual(copy.toString(), "abc")
    }
}
