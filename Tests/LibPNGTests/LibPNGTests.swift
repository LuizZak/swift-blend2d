import XCTest
import CLibPNG
import LibPNG

class LibPNGTests: XCTestCase {
    func testReadFromFile() throws {
        let path = "\(pathToResources())/bl-getting-started-1.png"
        
        let pngFile = try readPngFile(path)
        
        XCTAssertEqual(pngFile.bitDepth, 8)
        XCTAssertEqual(pngFile.colorType, png_byte(PNG_COLOR_TYPE_RGB_ALPHA))
        XCTAssertEqual(pngFile.width, 480)
        XCTAssertEqual(pngFile.height, 480)
        XCTAssertEqual(pngFile.rows.count, Int(pngFile.height))
        XCTAssert(pngFile.rows.allSatisfy { $0.count == Int(pngFile.rowLength) })
    }
    
    func testFromRgba() {
        let pngFile = PNGFile.fromRgba([1, 2, 3, 4], width: 2, height: 2)
        
        XCTAssertEqual(pngFile.width, 2)
        XCTAssertEqual(pngFile.height, 2)
        XCTAssertEqual(pngFile.bitDepth, 8)
        XCTAssertEqual(pngFile.colorType, png_byte(PNG_COLOR_TYPE_RGB_ALPHA))
        XCTAssertEqual(pngFile.rowLength, 2 * MemoryLayout<UInt32>.size)
        XCTAssertEqual(pngFile.rows.count, Int(pngFile.height))
        XCTAssert(pngFile.rows.allSatisfy { $0.count == Int(pngFile.rowLength) })
    }
}

func pathToResources() -> String {
    let file = #file
    return (((file as NSString)
        .deletingLastPathComponent as NSString)
        .appendingPathComponent("TestResources") as NSString)
        .standardizingPath
}
