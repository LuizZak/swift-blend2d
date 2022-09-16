import XCTest
import blend2d
import SwiftBlend2D

class BLFontManagerTests: XCTestCase {
    func testEphemeral() {
        let sut = BLFontManager()
        
        XCTAssertEqual(sut.faceCount, 0)
        XCTAssertEqual(sut.familyCount, 0)
    }
    
    func testAddFace() throws {
        let sut = BLFontManager()
        let face = try BLFontFace(fromFile: pathToTestFontFace())
        
        sut.addFace(face)
        
        XCTAssertEqual(sut.faceCount, 1)
        XCTAssertEqual(sut.familyCount, 1)
    }
    
    func testHasFace() throws {
        let sut = BLFontManager()
        let face = try BLFontFace(fromFile: pathToTestFontFace())
        sut.addFace(face)
        
        XCTAssert(sut.hasFace(face))
    }
    
    func testQueryFace() throws {
        let sut = BLFontManager()
        let face = try BLFontFace(fromFile: pathToTestFontFace())
        sut.addFace(face)
        
        let result = sut.queryFace(name: face.fullName.toString())
        
        XCTAssertEqual(face, result)
    }
    
    func testQueryFacesByFamilyName() throws {
        let sut = BLFontManager()
        let face = try BLFontFace(fromFile: pathToTestFontFace())
        sut.addFace(face)
        
        let result = sut.queryFacesByFamilyName(name: face.familyName.toString())
        
        XCTAssertEqual(result, [face])
    }
}
