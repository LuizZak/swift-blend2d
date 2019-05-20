import blend2d
import SwiftBlend2D
import AppKit
import TigerSample

let app = NSApplication.shared

class AppDelegate: NSObject, NSApplicationDelegate {
    var window = NSWindow(contentRect: NSMakeRect(200, 200, 612 * 0.8, 792 * 0.8),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered,
                          defer: false,
                          screen: nil)

    var timer: Timer!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let testView = TestView(frame: window.contentView!.bounds)
        testView.translatesAutoresizingMaskIntoConstraints = false

        window.makeKeyAndOrderFront(nil)
        window.contentView?.addSubview(testView)

        if #available(OSX 10.11, *) {
            testView.topAnchor.constraint(equalTo: window.contentView!.topAnchor).isActive = true
            testView.leftAnchor.constraint(equalTo: window.contentView!.leftAnchor).isActive = true
            testView.rightAnchor.constraint(equalTo: window.contentView!.rightAnchor).isActive = true
            testView.bottomAnchor.constraint(equalTo: window.contentView!.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }

        timer = Timer(timeInterval: 60 / 1000.0, target: self, selector: #selector(doThing), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
    }

    @objc
    func doThing() {
        window.contentView?.subviews[0].setNeedsDisplay(window.contentView!.bounds)
    }
}

struct Point {
    var position: BLPoint
    var velocity: BLPoint

    init(area: NSRect) {
        self.init(area: BLRect(x: Double(area.minX), y: Double(area.minY), w: Double(area.width), h: Double(area.height)))
    }

    init(area: BLRect) {
        position =
            area.topLeft
            + BLPoint(x: area.w, y: area.h)
            * BLPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))

        let angle = Double.random(in: 0..<(.pi * 2))
        let vel: Double = Double.random(in: 5...10)

        velocity = BLPoint(x: cos(angle) * vel, y: sin(angle) * vel)
    }

    mutating func integrate(area: NSRect) {
        integrate(area: BLRect(x: Double(area.minX), y: Double(area.minY), w: Double(area.width), h: Double(area.height)))
    }

    mutating func integrate(area: BLRect) {
        if position.x - velocity.x < area.left {
            position.x = area.left
            velocity.x *= -1
        }
        if position.y - velocity.y < area.top {
            position.y = area.top
            velocity.y *= -1
        }
        if position.x + velocity.x > area.right {
            position.x = area.right
            velocity.x *= -1
        }
        if position.y + velocity.y > area.bottom {
            position.y = area.bottom
            velocity.y *= -1
        }

        position += velocity
    }
}

extension BLPoint {
    func dot(_ other: BLPoint) -> Double {
        return x * other.x + y * other.y
    }
}

class TestView: NSView {
    let tiger = Tiger()

    var p0: Point!
    var p1: Point!
    var p2: Point!

    override func draw(_ dirtyRect: NSRect) {
        guard let context = NSGraphicsContext.current else {
            return
        }

        if p0 == nil {
            p0 = Point(area: bounds)
        }
        if p1 == nil {
            p1 = Point(area: bounds)
        }
        if p2 == nil {
            p2 = Point(area: bounds)
        }

        p0.integrate(area: bounds)
        p1.integrate(area: bounds)
        p2.integrate(area: bounds)

        let blImage = BLImage(width: Int(bounds.width), height: Int(bounds.height), format: .prgb32)
        let ctx = BLContext(image: blImage)!

        ctx.setFillStyle(BLRgba32.white)
        ctx.fillAll()

        ctx.setFillStyle(BLRgba32.cornflowerBlue)

        ctx.fillTriangle(BLTriangle(p0: p0.position, p1: p1.position, p2: p2.position))

        ctx.end()

        let codec = BLImageCodec(builtInCodec: .bmp)

        var data = Data()
        try! blImage.writeToData(data: &data, codec: codec)

        let nsImage = NSImage(data: data)

        var rect = bounds
        let cgImage = nsImage!.cgImage(forProposedRect: &rect, context: context, hints: nil)!

        context.cgContext.draw(cgImage, in: bounds)
        context.flushGraphics()

//        let blImage = BLImage(width: TigerData.width, height: TigerData.height, format: .prgb32)
//        let ctx = BLContext(image: blImage)!
//
//        ctx.setFillStyle(BLRgba32(argb: 0xFF00007F))
//        ctx.fillAll()
//
//        let phase = CACurrentMediaTime() * 2
//
//        let scale = 1 + cos(phase) * 0.07
//        let rotation = sin(-phase) / 5
//
//        ctx.scale(xy: scale)
//        ctx.postTranslate(x: Double(blImage.width / 2) * (1 - scale), y: Double(blImage.height / 2) * (1 - scale))
//        ctx.rotate(angle: rotation, point: BLPoint(x: Double(blImage.width) / 2, y: Double(blImage.height) / 2))
//
//        for tp in tiger.paths {
//            if tp.fill {
//                ctx.setFillStyle(tp.fillColor)
//                ctx.setFillRule(tp.fillRule)
//                ctx.fillPath(tp.blPath)
//            }
//
//            if tp.stroke {
//                ctx.setStrokeStyle(tp.strokeColor)
//                ctx.setStrokeOptions(tp.blStrokeOptions)
//                ctx.strokePath(tp.blPath)
//            }
//        }
//
//        ctx.end()
//
//        let codec = BLImageCodec(builtInCodec: .bmp)
//
//        var data = Data()
//        try! blImage.writeToData(data: &data, codec: codec)
//
//        let nsImage = NSImage(data: data)
//
//        var rect = bounds
//        let cgImage = nsImage!.cgImage(forProposedRect: &rect, context: context, hints: nil)!
//
//        context.cgContext.draw(cgImage, in: bounds)
//        context.flushGraphics()
    }
}

func main() throws {
    //try sample1()

    let delegate = AppDelegate()
    app.delegate = delegate
    app.run()
}

// C bindings are also available

func sample1WithCBindings() {
    var img = BLImageCore()
    
    blImageInit(&img)
    blImageCreate(&img, 480, 480, BL_FORMAT_PRGB32.rawValue)
    
    // Attach a rendering context into `img`.
    var ctx = BLContextCore()
    
    blContextInitAs(&ctx, &img, nil)
    
    // Clear the image.
    blContextSetCompOp(&ctx, BL_COMP_OP_SRC_COPY.rawValue)
    blContextFillAll(&ctx)
    
    // Fill some path.
    var path = BLPathCore()
    
    blPathInit(&path)
    blPathMoveTo(&path, 26, 31)
    blPathCubicTo(&path, 642, 132, 587, -136, 25, 464)
    blPathCubicTo(&path, 882, 404, 144, 267, 27, 31)
    
    blContextSetCompOp(&ctx, BL_COMP_OP_SRC_OVER.rawValue)
    blContextSetFillStyleRgba32(&ctx, 0xFFFFFFFF)
    blContextFillPathD(&ctx, &path)
    
    // Detach the rendering context from `img`.
    blContextEnd(&ctx)
    
    // Let's use some built-in codecs provided by Blend2D.
    var array = BLArrayCore()
    blImageCodecArrayInitBuiltInCodecs(&array)
    
    var codec = BLImageCodecCore()
    
    blImageCodecInit(&codec)
    blImageCodecFindByName(&codec, "BMP", 3, &array)
    
    blImageWriteToFile(&img, "bl-getting-started-1.bmp", &codec)
}

try main()
