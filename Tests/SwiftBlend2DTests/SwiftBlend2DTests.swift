import XCTest
import blend2d
import SwiftBlend2D

// TODO: Rewrite this test suite to use Blend2D's image saving functionality for
// recording and reading snapshot test results. This will ensure we can run this
// in Linux as well.

class SwiftBlend2DTests: XCTestCase {
    
    func testSample1() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        
        // Attach a rendering context into `img`.
        let ctx = BLContext(image: img)!
        
        // Clear the image.
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        // Fill some path.
        let path = BLPath()
        
        path.moveTo(x: 26, y: 31)
        path.cubicTo(x1: 642, y1: 132, x2: 587, y2: -136, x3: 25, y3: 464)
        path.cubicTo(x1: 882, y1: 404, x2: 144, y2: 267, x3: 27, y3: 31)
        
        ctx.compOp = .sourceOver
        ctx.setFillStyleRgba32(0xFFFFFFFF)
        ctx.fillPath(path)
        
        // Detach the rendering context from `img`.
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-1")

        #endif
    }
    
    func testSample2() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        // Coordinates can be specified now or changed later.
        var linear = BLGradient(linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 0, y1: 480))
        
        // Color stops can be added in any order.
        linear.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
        linear.addStop(0.5, BLRgba32(argb: 0xFF5FAFDF))
        linear.addStop(1.0, BLRgba32(argb: 0xFF2F5FDF))
        
        // `setFillStyle()` can be used for both colors and styles.
        ctx.setFillStyle(linear)
        
        ctx.compOp = .sourceOver
        ctx.fillRoundRect(x: 40.0, y: 40.0, width: 400.0, height: 400.0, radius: 45.5)
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-2")

        #endif
    }
    
    func testSample3() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        // Read an image from file.
        let texture = try BLImage(fromFile: "\(pathToResources())/texture.jpeg")
        
        // Create a pattern and use it to fill a rounded-rect.
        let pattern = BLPattern(image: texture)
        
        ctx.compOp = .sourceOver
        ctx.setFillStyle(pattern)
        ctx.fillRoundRect(x: 40.0, y: 40.0, width: 400.0, height: 400.0, radius: 45.5)
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-3")

        #endif
    }
    
    func testSample4() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        // Read an image from file.
        let texture = try BLImage(fromFile: "\(pathToResources())/texture.jpeg")
        
        // Rotate by 45 degrees about a point at [240, 240].
        ctx.rotate(angle: 0.785398, x: 240.0, y: 240.0)
        
        // Create a pattern.
        ctx.compOp = .sourceOver
        ctx.setFillStyle(BLPattern(image: texture))
        ctx.fillRoundRect(x: 50.0, y: 50.0, width: 380.0, height: 380.0, radius: 80.5)
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-4")

        #endif
    }
    
    func testSample5() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        // First shape filld by a radial gradient.
        var radial = BLGradient(radial: BLRadialGradientValues(x0: 180, y0: 180, x1: 180, y1: 180, r0: 180))
        radial.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
        radial.addStop(1.0, BLRgba32(argb: 0xFFFF6F3F))
        
        ctx.compOp = .sourceOver
        ctx.setFillStyle(radial)
        ctx.fillCircle(x: 180, y: 180, radius: 160)
        
        // Second shape filled by a linear gradient.
        var linear = BLGradient(linear: BLLinearGradientValues(x0: 195, y0: 195, x1: 470, y1: 470))
        linear.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
        linear.addStop(1.0, BLRgba32(argb: 0xFF3F9FFF))
        
        ctx.compOp = .difference
        ctx.setFillStyle(linear)
        ctx.fillRoundRect(x: 195, y: 195, width: 270, height: 270, radius: 25)
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-5")

        #endif
    }
    
    func testSample6() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        var linear = BLGradient(linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 0, y1: 480))
        linear.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
        linear.addStop(1.0, BLRgba32(argb: 0xFF1F7FFF))
        
        let path = BLPath()
        path.moveTo(x: 119, y: 49)
        path.cubicTo(x1: 259, y1: 29, x2: 99, y2: 279, x3: 275, y3: 267)
        path.cubicTo(x1: 537, y1: 245, x2: 300, y2: -170, x3: 274, y3: 430)
        
        ctx.compOp = .sourceOver
        ctx.setStrokeStyle(linear)
        ctx.setStrokeWidth(15)
        ctx.setStrokeStartCap(.round)
        ctx.setStrokeEndCap(.butt)
        ctx.strokePath(path)
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-6")

        #endif
    }
    
    func testSample7() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        
        let face = try BLFontFace(fromFile: "\(pathToResources())/NotoSans-Regular.ttf")
        
        let font = BLFont(fromFace: face, size: 50)
        
        ctx.setFillStyleRgba32(0xFFFFFFFF)
        ctx.fillText("Hello Blend2D!", at: BLPoint(x: 60, y: 80), font: font)
        
        ctx.rotate(angle: 0.785398)
        ctx.fillText("Rotated Text", at: BLPoint(x: 250, y: 80), font: font)
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-7")

        #endif
    }
    
    func testSample8() throws {
        #if canImport(Foundation)

        let img = BLImage(width: 480, height: 480, format: .prgb32)
        let ctx = BLContext(image: img)!
        
        ctx.compOp = .sourceCopy
        ctx.fillAll()
        ctx.setFillStyle(BLRgba32(argb: 0xFFFFFFFF))
        
        let face = try BLFontFace(fromFile: "\(pathToResources())/NotoSans-Regular.ttf")
        
        let font = BLFont(fromFace: face, size: 20.0)
        
        let fm = font.metrics
        var tm = BLTextMetrics()
        let gb = BLGlyphBuffer()
        
        var p = BLPoint(x: 20, y: 190 + Double(fm.ascent))
        let text = """
            Hello Blend2D!
            I'm a simple multiline text example
            that uses BLGlyphBuffer and fillGlyphRun!
            """
        
        let lines = text.split(separator: "\n")
        
        for line in lines {
            gb.setText(line)
            font.shape(gb)
            tm = font.getTextMetrics(gb)
            
            p.x = (480.0 - (tm.boundingBox.x1 - tm.boundingBox.x0)) / 2.0
            ctx.fillGlyphRun(gb.glyphRun, at: p, font: font)
            p.y += Double(fm.ascent + fm.descent + fm.lineGap)
        }
        
        ctx.end()
        
        assertImageMatch(img, "bl-getting-started-8")

        #endif
    }
}

#if canImport(Foundation)

extension SwiftBlend2DTests {
    func assertImageMatch(_ image: BLImage,
                          _ testName: String,
                          codec: BLImageCodec = BLImageCodec(builtInCodec: .bmp),
                          record: Bool = false,
                          file: String = #file,
                          line: Int = #line) {
        
        let snapshotsFolder = pathToSnapshots()
        let failuresFolder = pathToSnapshotFailures()
        let recordPath = (snapshotsFolder as NSString).appendingPathComponent("\(testName).\(codec.extensions[0])")
        let expectedPath = (failuresFolder as NSString).appendingPathComponent("\(testName)_expected.\(codec.extensions[0])")
        let failurePath = (failuresFolder as NSString).appendingPathComponent("\(testName)_actual.\(codec.extensions[0])")

        var isDirectory: ObjCBool = false
        if !FileManager.default.fileExists(atPath: snapshotsFolder, isDirectory: &isDirectory) {
            do {
                try FileManager.default.createDirectory(atPath: snapshotsFolder, withIntermediateDirectories: false, attributes: nil)
            } catch {
                recordFailure(withDescription: "Error attempting to create snapshots directory '\(snapshotsFolder)': \(error)",
                              inFile: file,
                              atLine: line,
                              expected: false)
                return
            }
        } else if !isDirectory.boolValue {
            recordFailure(withDescription: "Path to save snapshots to '\(snapshotsFolder)' exists but is a file, not a folder.",
                          inFile: file,
                          atLine: line,
                          expected: false)
            return
        }

        if record {
            do {
                try image.writeToFile(recordPath, codec: codec)

                recordFailure(withDescription: "Successfully recorded snapshot for \(testName)",
                             inFile: file,
                             atLine: line,
                             expected: true)
            } catch {
                recordFailure(withDescription: "Error attempting to save snapshot file at '\(recordPath)': \(error)",
                              inFile: file,
                              atLine: line,
                              expected: false)
                return
            }
        } else {
            do {
                let recordedData = try Data(contentsOf: URL(fileURLWithPath: recordPath))
                let actualData = try image.toData(codec: codec)

                if recordedData != actualData {
                    recordFailure(withDescription: "Snapshot \(testName) did not match recorded data. Please inspect image at \(failurePath) for further information.",
                                  inFile: file,
                                  atLine: line,
                                  expected: true)

                    try FileManager.default.createDirectory(atPath: pathToSnapshotFailures(),
                                                            withIntermediateDirectories: false,
                                                            attributes: nil)

                    FileManager.default.createFile(atPath: expectedPath, contents: recordedData, attributes: nil)
                    FileManager.default.createFile(atPath: failurePath, contents: actualData, attributes: nil)
                }
            } catch {
                recordFailure(withDescription: "Error attempting to read and compare snapshot '\(testName)': \(error)",
                              inFile: file,
                              atLine: line,
                              expected: false)
            }
        }
    }
}

func pathToSnapshots() -> String {
    let file = #file

    var path: NSString = (file as NSString).deletingLastPathComponent as NSString
    path = path.appendingPathComponent("Snapshots") as NSString

    return path as String
}

func pathToSnapshotFailures() -> String {
    let file = #file

    var path: NSString = (file as NSString).deletingLastPathComponent as NSString
    path = path.appendingPathComponent("SnapshotFailures"/* This path should be kept in .gitignore */) as NSString

    return path as String
}

func pathToResources() -> String {
    let file = #file
    return (((file as NSString)
        .deletingLastPathComponent as NSString)
        .appendingPathComponent("../../Resources") as NSString)
        .standardizingPath
}

#endif
