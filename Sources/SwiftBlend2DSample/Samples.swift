import SwiftBlend2D
import TigerSample

func sample1() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    
    // Attach a rendering context into `img`.
    let ctx = BLContext(image: img)!
    
    // Clear the image.
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    // Fill some path.
    let path = BLPath()
    
    path.moveTo(x: 26, y: 31)
    path.cubicTo(x1: 642, y1: 132, x2: 587, y2: -136, x3: 25, y3: 464)
    path.cubicTo(x1: 882, y1: 404, x2: 144, y2: 267, x3: 27, y3: 31)
    
    ctx.compOp = .srcOver
    ctx.setFillStyleRgba32(0xFFFFFFFF)
    ctx.fillPath(path)
    
    // Detach the rendering context from `img`.
    ctx.end()
    
    // Let's use some built-in codecs provided by Blend2D.
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-1.bmp", codec: codec)
}

func sample2() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    // Coordinates can be specified now or changed later.
    var linear = BLGradient(linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 0, y1: 480))
    
    // Color stops can be added in any order.
    linear.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
    linear.addStop(0.5, BLRgba32(argb: 0xFF5FAFDF))
    linear.addStop(1.0, BLRgba32(argb: 0xFF2F5FDF))
    
    // `setFillStyle()` can be used for both colors and styles.
    ctx.setFillStyle(linear)
    
    ctx.compOp = .srcOver
    ctx.fillRoundRect(x: 40.0, y: 40.0, width: 400.0, height: 400.0, radius: 45.5)
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-2.bmp", codec: codec)
}

func sample3() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    // Read an image from file.
    let texture = try BLImage(fromFile: "Resources/texture.jpeg")
    
    // Create a pattern and use it to fill a rounded-rect.
    let pattern = BLPattern(image: texture)
    
    ctx.compOp = .srcOver
    ctx.setFillStyle(pattern)
    ctx.fillRoundRect(x: 40.0, y: 40.0, width: 400.0, height: 400.0, radius: 45.5)
    
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-3.bmp", codec: codec)
}

func sample4() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    // Read an image from file.
    let texture = try BLImage(fromFile: "Resources/texture.jpeg")
    
    // Rotate by 45 degrees about a point at [240, 240].
    ctx.rotate(angle: 0.785398, x: 240.0, y: 240.0)
    
    // Create a pattern.
    ctx.compOp = .srcOver
    ctx.setFillStyle(BLPattern(image: texture))
    ctx.fillRoundRect(x: 50.0, y: 50.0, width: 380.0, height: 380.0, radius: 80.5)
    
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-4.bmp", codec: codec)
}

func sample5() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    // First shape filld by a radial gradient.
    var radial = BLGradient(radial: BLRadialGradientValues(x0: 180, y0: 180, x1: 180, y1: 180, r0: 180))
    radial.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
    radial.addStop(1.0, BLRgba32(argb: 0xFFFF6F3F))
    
    ctx.compOp = .srcOver
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
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-5.bmp", codec: codec)
}

func sample6() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    var linear = BLGradient(linear: BLLinearGradientValues(x0: 0, y0: 0, x1: 0, y1: 480))
    linear.addStop(0.0, BLRgba32(argb: 0xFFFFFFFF))
    linear.addStop(1.0, BLRgba32(argb: 0xFF1F7FFF))
    
    let path = BLPath()
    path.moveTo(x: 119, y: 49)
    path.cubicTo(x1: 259, y1: 29, x2: 99, y2: 279, x3: 275, y3: 267)
    path.cubicTo(x1: 537, y1: 245, x2: 300, y2: -170, x3: 274, y3: 430)
    
    ctx.compOp = .srcOver
    ctx.setStrokeStyle(linear)
    ctx.setStrokeWidth(15)
    ctx.setStrokeStartCap(.round)
    ctx.setStrokeEndCap(.butt)
    ctx.strokePath(path)
    
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-6.bmp", codec: codec)
}

func sample7() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    
    let face = try BLFontFace(fromFile: "Resources/NotoSans-Regular.ttf")
    
    let font = BLFont(fromFace: face, size: 50)
    
    ctx.setFillStyleRgba32(0xFFFFFFFF)
    ctx.fillText("Hello Blend2D!", at: BLPoint(x: 60, y: 80), font: font)
    
    ctx.rotate(angle: 0.785398)
    ctx.fillText("Rotated Text", at: BLPoint(x: 250, y: 80), font: font)
    
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-7.bmp", codec: codec)
}

func sample8() throws {
    let img = BLImage(width: 480, height: 480, format: .prgb32)
    let ctx = BLContext(image: img)!
    
    ctx.compOp = .srcCopy
    ctx.fillAll()
    ctx.setFillStyle(BLRgba32(argb: 0xFFFFFFFF))
    
    let face = try BLFontFace(fromFile: "Resources/NotoSans-Regular.ttf")
    let font = BLFont(fromFace: face, size: 20.0)
    
    let fm = font.metrics
    
    var p = BLPoint(x: 20, y: 190 + Double(fm.ascent))
    let text = """
        Hello Blend2D!
        I'm a simple multiline text example
        that uses BLGlyphBuffer and fillGlyphRun!
        """
    
    let lines = text.split(separator: "\n")
    
    for line in lines {
        let gb = BLGlyphBuffer(text: line)
        font.shape(gb)
        let tm = font.getTextMetrics(gb)
        
        p.x = (480.0 - (tm.boundingBox.x1 - tm.boundingBox.x0)) / 2.0
        ctx.fillGlyphRun(gb.glyphRun, at: p, font: font)
        p.y += Double(fm.ascent + fm.descent + fm.lineGap)
    }
    
    ctx.end()
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-8.bmp", codec: codec)
}

func tigerSample() throws {
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
    
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("tiger.bmp", codec: codec)
}
