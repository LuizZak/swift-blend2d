import blend2d
import SwiftBlend2D

func main() throws {
    try sample1()
}

// C bindings are also available

func sample1WithCBindings() {
    var img = BLImageCore()

    bl_image_init(&img)
    bl_image_create(&img, 480, 480, BL_FORMAT_PRGB32)

    // Attach a rendering context into `img`.
    var ctx = BLContextCore()

    bl_context_init_as(&ctx, &img, nil)

    // Clear the image.
    bl_context_set_comp_op(&ctx, BL_COMP_OP_SRC_COPY)
    bl_context_fill_all(&ctx)

    // Fill some path.
    var path = BLPathCore()

    bl_path_init(&path)
    bl_path_move_to(&path, 26, 31)
    bl_path_cubic_to(&path, 642, 132, 587, -136, 25, 464)
    bl_path_cubic_to(&path, 882, 404, 144, 267, 27, 31)

    bl_context_set_comp_op(&ctx, BL_COMP_OP_SRC_OVER)
    bl_context_set_fill_style_rgba32(&ctx, 0xFFFFFFFF)
    var zero = BLPoint.zero
    bl_context_fill_path_d(&ctx, &zero, &path)

    // Detach the rendering context from `img`.
    bl_context_end(&ctx)

    // Let's use some built-in codecs provided by Blend2D.
    var array = BLArrayCore()
    bl_image_codec_array_init_built_in_codecs(&array)

    var codec = BLImageCodecCore()

    bl_image_codec_init(&codec)
    bl_image_codec_find_by_name(&codec, "BMP", 3, &array)

    bl_image_write_to_file(&img, "bl-getting-started-1.bmp", &codec)
}

try main()
