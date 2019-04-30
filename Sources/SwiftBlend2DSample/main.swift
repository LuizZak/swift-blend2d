import blend2d
import SwiftBlend2D

func main() throws {
    let img = BLImage(width: 480, height: 480, format: BL_FORMAT_PRGB32)
    
    // Attach a rendering context into `img`.
    let ctx = BLContext(image: img)!
    
    // Clear the image.
    ctx.setCompOp(BL_COMP_OP_SRC_COPY)
    ctx.fillAll()
    
    // Fill some path.
    let path = BLPath()
    
    path.moveTo(x: 26, y: 31)
    path.cubicTo(x1: 642, y1: 132, x2: 587, y2: -136, x3: 25, y3: 464)
    path.cubicTo(x1: 882, y1: 404, x2: 144, y2: 267, x3: 27, y3: 31)
    
    ctx.setCompOp(BL_COMP_OP_SRC_OVER)
    ctx.setFillStyleRgba32(0xFFFFFFFF)
    ctx.fillPath(path)
    
    // Detach the rendering context from `img`.
    ctx.end()
    
    // Let's use some built-in codecs provided by Blend2D.
    let codec = BLImageCodec(builtInCodec: .bmp)
    
    try img.writeToFile("bl-getting-started-1.bmp", codec: codec)
}

// C bindings are also available

func mainWithCBindings() {
    var img = BLImageCore()//img(480, 480, BL_FORMAT_PRGB32);
    
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
    blPathCubicTo(&path, 642, 132, 587, -136, 25, 464);
    blPathCubicTo(&path, 882, 404, 144, 267, 27, 31);
    
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
