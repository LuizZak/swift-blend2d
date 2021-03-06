import XCTest
import blend2d
@testable import SwiftBlend2D

class BLImageTests: XCTestCase {
    func testInitDefault() {
        let image = BLImage()
        
        assertIsDefaultPointer(image.object)
    }
    
    func testInitWithSize() {
        let image = BLImage(width: 32, height: 32, format: .prgb32)
        
        assertIsNonDefaultPointer(image.object)
    }
    
    func testSize() {
        let image = BLImage(width: 32, height: 48, format: .prgb32)
        
        XCTAssertEqual(image.size, BLSizeI(w: 32, h: 48))
        XCTAssertEqual(image.width, 32)
        XCTAssertEqual(image.height, 48)
    }
    
    func testWriteToData() throws {
        let image = BLImage(width: 1, height: 1, format: .prgb32)
        let context = BLContext(image: image)!
        context.setFillStyleRgba32(0xFFFF00FF)
        context.fillAll()
        context.end()
        
        let array = BLArray<UInt8>()
        let codec = BLImageCodec(builtInCodec: .bmp)
        
        try image.writeToData(array, codec: codec)
        
        let data = array.asArray()
        XCTAssertEqual(
            data, [
                // BMP header
                66, 77, 126, 0, 0, 0, 0, 0, 0, 0, 122,
                // BIP header
                0, 0, 0, 108, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 32, 0, 0, 0,
                0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0, 0, 0, 0, 0, 255, 1, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                // Image data
                255, 0, 255, 255
            ]
        )
    }
    
    func testReadFromData() throws {
        let image = BLImage()
        let data: [UInt8] = [
            // BMP header
            66, 77, 74, 0, 0, 0, 0, 0, 0, 0, 70,
            // BIP header
            0, 0, 0, 56, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 32, 0, 0, 0,
            0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0, 0, 0, 0, 0, 255,
            // Image data
            255, 0, 255, 255
        ]
        
        try image.readFromData(data, codecs: BLImageCodec.builtInCodecs)
        
        XCTAssertEqual(image.width, 1)
        XCTAssertEqual(image.height, 1)
    }
}

extension BLImageTests {
    
    static var nilImageImpl: UnsafeMutablePointer<BLImageImpl> {
        var imageCore = BLImageCore()
        blImageInit(&imageCore)
        return imageCore.impl
    }
    
    func assertIsNonDefaultPointer(_ imageCore: BLImageCore,
                                   file: StaticString = #file,
                                   line: UInt = #line) {
        if imageCore.impl == nil {
            XCTFail("""
                Provided image core has a nil-pointer to its inner BLImageImpl value.
                Did you forget to invoke blImageInit()?
                """, file: file, line: line)
        } else if imageCore.impl == BLImageTests.nilImageImpl {
            XCTFail("""
                Expected image implementation to not point to \(BLImageTests.nilImageImpl) (default image implementation).
                """, file: file, line: line)
        }
    }
    
    func assertIsDefaultPointer(_ imageCore: BLImageCore,
                                file: StaticString = #file,
                                line: UInt = #line) {

        XCTAssertNotNil(imageCore.impl, """
            Provided image core has a nil-pointer to its inner BLImageImpl value.
            Did you forget to invoke blImageInit()?
            """, file: file, line: line)

        XCTAssertEqual(imageCore.impl, BLImageTests.nilImageImpl, """
            Expected image implementation to point to \(BLImageTests.nilImageImpl) \
            (default image implementation), but found a pointer to \(imageCore.impl as Any) instead.
            """, file: file, line: line)
    }
}
