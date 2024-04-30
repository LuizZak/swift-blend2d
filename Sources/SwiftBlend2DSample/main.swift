import blend2d
import SwiftBlend2D

func main() throws {
    try sample1()
}

// C bindings are also available

func sample1WithCBindings() {
    var img = BLImageCore()
    
    blImageInit(&img)
    blImageCreate(&img, 480, 480, BL_FORMAT_PRGB32)
    
    // Attach a rendering context into `img`.
    var ctx = BLContextCore()
    
    blContextInitAs(&ctx, &img, nil)
    
    // Clear the image.
    blContextSetCompOp(&ctx, BL_COMP_OP_SRC_COPY)
    blContextFillAll(&ctx)
    
    // Fill some path.
    var path = BLPathCore()
    
    blPathInit(&path)
    blPathMoveTo(&path, 26, 31)
    blPathCubicTo(&path, 642, 132, 587, -136, 25, 464)
    blPathCubicTo(&path, 882, 404, 144, 267, 27, 31)
    
    blContextSetCompOp(&ctx, BL_COMP_OP_SRC_OVER)
    blContextSetFillStyleRgba32(&ctx, 0xFFFFFFFF)
    var zero = BLPoint.zero
    blContextFillPathD(&ctx, &zero, &path)
    
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
