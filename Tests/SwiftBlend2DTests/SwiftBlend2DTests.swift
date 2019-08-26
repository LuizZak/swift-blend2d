import XCTest
import Foundation
import blend2d
import SwiftBlend2D
import TigerSample
import LibPNG

class SwiftBlend2DTests: XCTestCase {
    
    func testSample1() throws {
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
    }
    
    func testSample2() throws {
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
    }
    
    func testSample3() throws {
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
    }
    
    func testSample4() throws {
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
    }
    
    func testSample5() throws {
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
    }
    
    func testSample6() throws {
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
    }
    
    func testSample7() throws {
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
    }
    
    func testSample8() throws {
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
    }

    func testTiger() throws {
        let tiger = Tiger()

        let img = BLImage(width: TigerData.width, height: TigerData.height, format: .prgb32)
        let ctx = BLContext(image: img)!

        ctx.setFillStyle(BLRgba32(argb: 0xFF00007F))
        ctx.fillAll()

        for tp in tiger.paths {
            if tp.fill {
                ctx.setFillStyle(tp.fillColor)
                ctx.fillRule = tp.fillRule
                ctx.fillPath(tp.blPath)
            }

            if tp.stroke {
                ctx.setStrokeStyle(tp.strokeColor)
                ctx.setStrokeOptions(tp.blStrokeOptions)
                ctx.strokePath(tp.blPath)
            }
        }

        ctx.end()

        assertImageMatch(img, "tiger")
    }

    func testConicalGradient() {
        let img = BLImage(width: 200, height: 200, format: .prgb32)
        let ctx = BLContext(image: img)!

        var gradient = BLGradient(conical: BLConicalGradientValues(x0: 100, y0: 100, angle: .pi / 2))
        gradient.addStop(0, BLRgba32.green)
        gradient.addStop(1, BLRgba32.yellow)

        ctx.setFillStyle(gradient)

        ctx.fillCircle(x: 100, y: 100, radius: 50)

        ctx.end()

        assertImageMatch(img, "conical-angled")
    }

    func testStrokeShapes() {
        let img = BLImage(width: 360, height: 50, format: .prgb32)
        let ctx = BLContext(image: img)!

        ctx.setFillStyle(BLRgba32.white)
        ctx.clearAll()

        ctx.setStrokeStyle(BLRgba32.aliceBlue)

        // Line
        do {
            ctx.strokeLine(x0: 5, y0: 5, x1: 20, y1: 20)
        }
        // Box
        do {
            ctx.strokeBox(x0: 25, y0: 5, x1: 45, y1: 35)
        }
        // Rect
        do {
            ctx.strokeRect(x: 50, y: 5, w: 20, h: 25)
        }
        // Arc
        do {
            ctx.strokeArc(cx: 90, cy: 10, rx: 15, ry: 15, start: 0, sweep: .pi)
        }
        // Pie
        do {
            ctx.strokePie(cx: 120, cy: 15, rx: 10, ry: 15, start: 0, sweep: .pi)
        }
        // Chord
        do {
            ctx.strokeChord(cx: 150, cy: 15, rx: 10, ry: 15, start: 0, sweep: .pi)
        }
        // Circle
        do {
            ctx.strokeCircle(x: 180, y: 20, radius: 15)
        }
        // Ellipse
        do {
            ctx.strokeEllipse(x: 215, y: 20, radiusX: 15, radiusY: 10)
        }
        // Triangle
        do {
            ctx.strokeTriangle(x0: 235, y0: 5, x1: 250, y1: 15, x2: 245, y2: 25)
        }
        // Rounded rectangle
        do {
            ctx.strokeRoundRect(x: 255, y: 5, width: 25, height: 20, radiusX: 10, radiusY: 5)
        }
        // Stroke polyline
        do {
            ctx.strokePolyline([
                BLPoint(x: 290, y: 5),
                BLPoint(x: 320, y: 10),
                BLPoint(x: 310, y: 20),
            ])
        }
        // Stroke polygon
        do {
            ctx.strokePolygon([
                BLPoint(x: 325, y: 5),
                BLPoint(x: 355, y: 10),
                BLPoint(x: 335, y: 20),
            ])
        }

        ctx.end()

        assertImageMatch(img, "stroke-shapes")
    }

    func testFillShapes() {
        let img = BLImage(width: 270, height: 50, format: .prgb32)
        let ctx = BLContext(image: img)!

        ctx.setFillStyle(BLRgba32.white)
        ctx.clearAll()

        ctx.setFillStyle(BLRgba32.cornflowerBlue)
        
        // Box
        do {
            ctx.fillBox(x0: 5, y0: 5, x1: 25, y1: 35)
        }
        // Rect
        do {
            ctx.fillRect(x: 30, y: 5, width: 20, height: 25)
        }
        // Pie
        do {
            ctx.fillPie(cx: 70, cy: 15, rx: 10, ry: 15, start: 0, sweep: .pi)
        }
        // Chord
        do {
            ctx.fillChord(cx: 100, cy: 15, rx: 10, ry: 15, start: 0, sweep: .pi)
        }
        // Circle
        do {
            ctx.fillCircle(x: 130, y: 20, radius: 15)
        }
        // Ellipse
        do {
            ctx.fillEllipse(x: 165, y: 20, radiusX: 15, radiusY: 10)
        }
        // Triangle
        do {
            ctx.fillTriangle(x0: 185, y0: 5, x1: 200, y1: 15, x2: 195, y2: 25)
        }
        // Rounded rectangle
        do {
            ctx.fillRoundRect(x: 205, y: 5, width: 25, height: 20, radiusX: 10, radiusY: 5)
        }
        // Fill polygon
        do {
            ctx.fillPolygon([
                BLPoint(x: 235, y: 5),
                BLPoint(x: 265, y: 10),
                BLPoint(x: 245, y: 20),
            ])
        }

        ctx.end()

        assertImageMatch(img, "fill-shapes")
    }
}

func pngFileFromImage(_ image: BLImage) -> PNGFile {
    let data = image.getData()
    
    assert(data.format == BLFormat.prgb32.rawValue)
    
    let bytes =
        UnsafeBufferPointer<UInt32>(start: data.pixelData.assumingMemoryBound(to: UInt32.self),
                                    count: data.stride * Int(data.size.h))
    
    return PNGFile.fromArgb(bytes, width: image.width, height: image.height)
}

extension SwiftBlend2DTests {
    func assertImageMatch(_ image: BLImage,
                          _ testName: String,
                          record: Bool = false,
                          file: String = #file,
                          line: Int = #line) {
        
        let snapshotsFolder = pathToSnapshots()
        let failuresFolder = pathToSnapshotFailures()
        let recordPath = snapshotsFolder + "/\(testName).png"
        let expectedPath = failuresFolder + "/\(testName)_expected.png"
        let failurePath = failuresFolder + "/\(testName)_actual.png"

        var isDirectory: Bool = false
        if !pathExists(snapshotsFolder, isDirectory: &isDirectory) {
            do {
                try createDirectory(atPath: snapshotsFolder)
            } catch {
                recordFailure(withDescription: "Error attempting to create snapshots directory '\(snapshotsFolder)': \(error)",
                              inFile: file,
                              atLine: line,
                              expected: false)
                return
            }
        } else if !isDirectory {
            recordFailure(withDescription: "Path to save snapshots to '\(snapshotsFolder)' exists but is a file, not a folder.",
                          inFile: file,
                          atLine: line,
                          expected: false)
            return
        }

        if record {
            do {
                let pngFile = pngFileFromImage(image)
                
                try writePngFile(file: pngFile, filename: recordPath)

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
                let recordedData = try readPngFile(recordPath)
                let actualData = pngFileFromImage(image)

                if recordedData != actualData {
                    recordFailure(withDescription: "Snapshot \(testName) did not match recorded data. Please inspect image at \(failurePath) for further information.",
                                  inFile: file,
                                  atLine: line,
                                  expected: true)
                    
                    try createDirectory(atPath: pathToSnapshotFailures())
                    
                    try copyFile(source: recordPath, dest: expectedPath)
                    try writePngFile(file: actualData, filename: failurePath)
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

// TODO: Make this path shenanigans portable to Windows

let rootPath: String = "/"
let pathSeparator: Character = "/"

func pathToSnapshots() -> String {
    let file = #file

    return rootPath + file.split(separator: pathSeparator).dropLast().joined(separator: String(pathSeparator)) + "\(pathSeparator)Snapshots"
}

func pathToSnapshotFailures() -> String {
    let file = #file

    return rootPath + file.split(separator: pathSeparator).dropLast().joined(separator: String(pathSeparator))
        + "\(pathSeparator)SnapshotFailures" /* This path should be kept in .gitignore */
}

func pathToResources() -> String {
    let file = #file
    
    return rootPath + file.split(separator: pathSeparator).dropLast(3).joined(separator: String(pathSeparator))
        + "\(pathSeparator)Resources"
}

func pathExists(_ path: String, isDirectory: inout Bool) -> Bool {
    var objcBool: ObjCBool = ObjCBool(false)
    defer {
        isDirectory = objcBool.boolValue
    }
    return FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
}

func createDirectory(atPath path: String) throws {
    try FileManager.default.createDirectory(at: URL(fileURLWithPath: path),
                                            withIntermediateDirectories: true,
                                            attributes: nil)
}

func copyFile(source: String, dest: String) throws {
    if FileManager.default.fileExists(atPath: dest) {
        try FileManager.default.removeItem(atPath: dest)
    }
    try FileManager.default.copyItem(atPath: source, toPath: dest)
}
