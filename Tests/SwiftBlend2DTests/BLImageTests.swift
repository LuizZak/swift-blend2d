import XCTest
import blend2d
@testable import SwiftBlend2D

class BLImageTests: XCTestCase {
    func testInitWithWithHeight() {
        let image = BLImage(width: 32, height: 48, format: .prgb32)

        XCTAssertEqual(image.width, 32)
        XCTAssertEqual(image.height, 48)
    }

    func testInitWithSize() {
        let image = BLImage(size: BLSizeI(w: 32, h: 48), format: .prgb32)

        XCTAssertEqual(image.width, 32)
        XCTAssertEqual(image.height, 48)
    }

    func testInitFromUnownedMemory() throws {
        var pixels: [UInt8] = [
            0,  1,   2,  3,
            4,  5,   6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]

        pixels.withUnsafeMutableBufferPointer { pointer in
            let size = BLSizeI(w: 1, h: 4)

            let image = BLImage(
                fromUnownedData: pointer.baseAddress!,
                stride: 4,
                size: size,
                format: .prgb32
            )

            let imageData = image.getImageData()
            let pixelData = imageData.pixel_data.assumingMemoryBound(to: UInt8.self)
            XCTAssertEqual(
                Array(UnsafeMutableBufferPointer(start: pixelData, count: 16)),
                Array(pointer)
            )
            XCTAssertEqual(imageData.size, size)
            XCTAssertEqual(imageData.stride, 4)
            XCTAssertEqual(
                BLFormat(BLFormat.RawValue(imageData.format)),
                BLFormat.prgb32
            )
        }
    }

    func testInitFromUnownedMemory_doesNotCopyData() throws {
        var pixels: [UInt8] = [
            0,  1,   2,  3,
            4,  5,   6,  7,
            8,  9,  10, 11,
            12, 13, 14, 15
        ]
        pixels.withUnsafeMutableBufferPointer { pointer in
            let size = BLSizeI(w: 1, h: 4)

            let image = BLImage(
                fromUnownedData: pointer.baseAddress!,
                stride: 4,
                size: size,
                format: .prgb32
            )
            pointer[5] = 0

            let imageData = image.getImageData()
            let pixelData = imageData.pixel_data.assumingMemoryBound(to: UInt8.self)
            XCTAssertEqual(
                Array(UnsafeMutableBufferPointer(start: pixelData, count: 16)),
                Array(pointer)
            )
            XCTAssertEqual(imageData.size, size)
            XCTAssertEqual(imageData.stride, 4)
            XCTAssertEqual(
                BLFormat(BLFormat.RawValue(imageData.format)),
                BLFormat.prgb32
            )
        }
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
