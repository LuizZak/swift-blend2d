import blend2d

public extension BLHitTest {
    /// Fully in.
    static let `in` = BL_HIT_TEST_IN
    /// Partially in/out.
    static let partial = BL_HIT_TEST_PART
    /// Fully out.
    static let out = BL_HIT_TEST_OUT
}

public extension BLFillRule {
    /// Non-zero fill-rule.
    static let zero = BL_FILL_RULE_NON_ZERO
    /// Even-odd fill-rule.
    static let odd = BL_FILL_RULE_EVEN_ODD
}

public extension BLPathReverseMode {
    /// Reverse each figure and their order as well (default).
    static let complete = BL_PATH_REVERSE_MODE_COMPLETE
    
    /// Reverse each figure separately (keeps their order).
    static let separate = BL_PATH_REVERSE_MODE_SEPARATE
}

public extension BLGeometryDirection {
    /// No direction specified.
    static let none = BL_GEOMETRY_DIRECTION_NONE
    /// Clockwise direction.
    static let cw = BL_GEOMETRY_DIRECTION_CW
    /// Counter-clockwise direction.
    static let ccw = BL_GEOMETRY_DIRECTION_CCW
}

public extension BLStrokeJoin {
    /// Miter-join possibly clipped at `miterLimit` [default].
    static let miterClip = BL_STROKE_JOIN_MITER_CLIP
    /// Miter-join or bevel-join depending on miterLimit condition.
    static let miterBevel = BL_STROKE_JOIN_MITER_BEVEL
    /// Miter-join or round-join depending on miterLimit condition.
    static let miterRound = BL_STROKE_JOIN_MITER_ROUND
    /// Bevel-join.
    static let bevel = BL_STROKE_JOIN_BEVEL
    /// Round-join.
    static let round = BL_STROKE_JOIN_ROUND
}

public extension BLStrokeCapPosition {
    /// Start of the path.
    static let start = BL_STROKE_CAP_POSITION_START
    /// End of the path.
    static let end = BL_STROKE_CAP_POSITION_END
}

public extension BLStrokeCap {
    /// Butt cap [default].
    static let butt = BL_STROKE_CAP_BUTT
    /// Square cap.
    static let square = BL_STROKE_CAP_SQUARE
    /// Round cap.
    static let round = BL_STROKE_CAP_ROUND
    /// Round cap reversed.
    static let roundReversed = BL_STROKE_CAP_ROUND_REV
    /// Triangle cap.
    static let triangle = BL_STROKE_CAP_TRIANGLE
    /// Triangle cap reversed.
    static let triangleReversed = BL_STROKE_CAP_TRIANGLE_REV
}

public extension BLStrokeTransformOrder {
    /// Transform after stroke  => `Transform(Stroke(Input))` [default].
    static let after = BL_STROKE_TRANSFORM_ORDER_AFTER
    /// Transform before stroke => `Stroke(Transform(Input))`.
    static let before = BL_STROKE_TRANSFORM_ORDER_BEFORE
}

public extension BLGeometryType {
    /// No geometry provided.
    static let none = BL_GEOMETRY_TYPE_NONE
    /// BLBoxI struct.
    static let boxi = BL_GEOMETRY_TYPE_BOXI
    /// BLBox struct.
    static let boxd = BL_GEOMETRY_TYPE_BOXD
    /// BLRectI struct.
    static let recti = BL_GEOMETRY_TYPE_RECTI
    /// BLRect struct.
    static let rectd = BL_GEOMETRY_TYPE_RECTD
    /// BLCircle struct.
    static let circle = BL_GEOMETRY_TYPE_CIRCLE
    /// BLEllipse struct.
    static let ellipse = BL_GEOMETRY_TYPE_ELLIPSE
    /// BLRoundRect struct.
    static let round_rect = BL_GEOMETRY_TYPE_ROUND_RECT
    /// BLArc struct.
    static let arc = BL_GEOMETRY_TYPE_ARC
    /// BLArc struct representing chord.
    static let chord = BL_GEOMETRY_TYPE_CHORD
    /// BLArc struct representing pie.
    static let pie = BL_GEOMETRY_TYPE_PIE
    /// BLLine struct.
    static let line = BL_GEOMETRY_TYPE_LINE
    /// BLTriangle struct.
    static let triangle = BL_GEOMETRY_TYPE_TRIANGLE
    /// BLArrayView<BLPointI> representing a polyline.
    static let polylinei = BL_GEOMETRY_TYPE_POLYLINEI
    /// BLArrayView<BLPoint> representing a polyline.
    static let polylined = BL_GEOMETRY_TYPE_POLYLINED
    /// BLArrayView<BLPointI> representing a polygon.
    static let polygoni = BL_GEOMETRY_TYPE_POLYGONI
    /// BLArrayView<BLPoint> representing a polygon.
    static let polygond = BL_GEOMETRY_TYPE_POLYGOND
    /// BLArrayView<BLBoxI> struct.
    static let arrayViewBoxI = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXI
    /// BLArrayView<BLBox> struct.
    static let arrayViewBoxD = BL_GEOMETRY_TYPE_ARRAY_VIEW_BOXD
    /// BLArrayView<BLRectI> struct.
    static let arrayViewRectI = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTI
    /// BLArrayView<BLRect> struct.
    static let arrayViewRectD = BL_GEOMETRY_TYPE_ARRAY_VIEW_RECTD
    /// BLPath (or BLPathCore).
    static let path = BL_GEOMETRY_TYPE_PATH
    /// BLRegion (or BLRegionCore).
    static let region = BL_GEOMETRY_TYPE_REGION
}

public extension BLContextFlushFlags {
    /// Wait for completion (block).
    static let sync = BL_CONTEXT_FLUSH_SYNC
}

public extension BLRenderingQuality {
    /// Render using anti-aliasing.
    static let antialias = BL_RENDERING_QUALITY_ANTIALIAS
}

public extension BLPatternQuality {
    /// Nearest neighbor.
    static let nearestNeighbor = BL_PATTERN_QUALITY_NEAREST
    /// Bilinear.
    static let bilinear = BL_PATTERN_QUALITY_BILINEAR
}

public extension BLGradientQuality {
    /// Nearest neighbor.
    static let nearest = BL_GRADIENT_QUALITY_NEAREST
}

public extension BLFlattenMode {
    /// Use default mode (decided by Blend2D).
    static let `default` = BL_FLATTEN_MODE_DEFAULT
    /// Recursive subdivision flattening.
    static let recursive = BL_FLATTEN_MODE_RECURSIVE
}

public extension BLTextEncoding {
    /// UTF-8 encoding.
    static let utf8 = BL_TEXT_ENCODING_UTF8
    /// UTF-16 encoding (native endian).
    static let utf16 = BL_TEXT_ENCODING_UTF16
    /// UTF-32 encoding (native endian).
    static let utf32 = BL_TEXT_ENCODING_UTF32
    /// LATIN1 encoding (one byte per character).
    static let latin1 = BL_TEXT_ENCODING_LATIN1
    
    /// Platform native `wchar_t` (or Windows `WCHAR`) encoding, alias to
    /// either UTF-32, UTF-16, or UTF-8 depending on `sizeof(wchar_t)`.
    static let wchar = BL_TEXT_ENCODING_WCHAR
}

public extension BLImageScaleFilter {
    /// No filter or uninitialized.
    static let none = BL_IMAGE_SCALE_FILTER_NONE
    /// Nearest neighbor filter (radius 1.0).
    static let nearest = BL_IMAGE_SCALE_FILTER_NEAREST
    /// Bilinear filter (radius 1.0).
    static let bilinear = BL_IMAGE_SCALE_FILTER_BILINEAR
    /// Bicubic filter (radius 2.0).
    static let bicubic = BL_IMAGE_SCALE_FILTER_BICUBIC
    /// Bell filter (radius 1.5).
    static let bell = BL_IMAGE_SCALE_FILTER_BELL
    /// Gauss filter (radius 2.0).
    static let gauss = BL_IMAGE_SCALE_FILTER_GAUSS
    /// Hermite filter (radius 1.0).
    static let hermite = BL_IMAGE_SCALE_FILTER_HERMITE
    /// Hanning filter (radius 1.0).
    static let hanning = BL_IMAGE_SCALE_FILTER_HANNING
    /// Catrom filter (radius 2.0).
    static let catrom = BL_IMAGE_SCALE_FILTER_CATROM
    /// Bessel filter (radius 3.2383).
    static let bessel = BL_IMAGE_SCALE_FILTER_BESSEL
    /// Sinc filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let sinc = BL_IMAGE_SCALE_FILTER_SINC
    /// Lanczos filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let lanczos = BL_IMAGE_SCALE_FILTER_LANCZOS
    /// Blackman filter (radius 2.0, adjustable through `BLImageScaleOptions`).
    static let blackman = BL_IMAGE_SCALE_FILTER_BLACKMAN
    /// Mitchell filter (radius 2.0, parameters 'b' and 'c' passed through `BLImageScaleOptions`).
    static let mitchell = BL_IMAGE_SCALE_FILTER_MITCHELL
    /// Filter using a user-function, must be passed through `BLImageScaleOptions`.
    static let user = BL_IMAGE_SCALE_FILTER_USER
}

internal extension BLImplType {
    /// Type is `Null`.
    static let null = BL_IMPL_TYPE_NULL
    
    /// Type is `BLBitArray`.
    static let bitArray = BL_IMPL_TYPE_BIT_ARRAY
    
    /// Type is `BLString`.
    static let string = BL_IMPL_TYPE_STRING
    
    /// Type is `BLArray<T>` where `T` is `BLVariant` or other ref-counted type.
    static let arrayOfVar = BL_IMPL_TYPE_ARRAY_VAR
    
    /// Type is `BLArray<T>` where `T` matches 8-bit signed integral type.
    static let arrayOfInt8 = BL_IMPL_TYPE_ARRAY_I8
    
    /// Type is `BLArray<T>` where `T` matches 8-bit unsigned integral type.
    static let arrayOfUInt8 = BL_IMPL_TYPE_ARRAY_U8
    
    /// Type is `BLArray<T>` where `T` matches 16-bit signed integral type.
    static let arrayOfInt16 = BL_IMPL_TYPE_ARRAY_I16
    
    /// Type is `BLArray<T>` where `T` matches 16-bit unsigned integral type.
    static let arrayOfUInt16 = BL_IMPL_TYPE_ARRAY_U16
    
    /// Type is `BLArray<T>` where `T` matches 32-bit signed integral type.
    static let arrayOfInt32 = BL_IMPL_TYPE_ARRAY_I32
    
    /// Type is `BLArray<T>` where `T` matches 32-bit unsigned integral type.
    static let arrayOfUInt32 = BL_IMPL_TYPE_ARRAY_U32
    
    /// Type is `BLArray<T>` where `T` matches 64-bit signed integral type.
    static let arrayOfInt64 = BL_IMPL_TYPE_ARRAY_I64
    
    /// Type is `BLArray<T>` where `T` matches 64-bit unsigned integral type.
    static let arrayOfUInt64 = BL_IMPL_TYPE_ARRAY_U64
    
    /// Type is `BLArray<T>` where `T` matches 32-bit floating point type.
    static let arrayOfFloat32 = BL_IMPL_TYPE_ARRAY_F32
    
    /// Type is `BLArray<T>` where `T` matches 64-bit floating point type.
    static let arrayOfFloat64 = BL_IMPL_TYPE_ARRAY_F64
    
    /// Type is `BLArray<T>` where `T` is a struct of size 1.
    static let arrayOfStruct_1 = BL_IMPL_TYPE_ARRAY_STRUCT_1
    
    /// Type is `BLArray<T>` where `T` is a struct of size 2.
    static let arrayOfStruct_2 = BL_IMPL_TYPE_ARRAY_STRUCT_2
    
    /// Type is `BLArray<T>` where `T` is a struct of size 3.
    static let arrayOfStruct_3 = BL_IMPL_TYPE_ARRAY_STRUCT_3
    
    /// Type is `BLArray<T>` where `T` is a struct of size 4.
    static let arrayOfStruct_4 = BL_IMPL_TYPE_ARRAY_STRUCT_4
    
    /// Type is `BLArray<T>` where `T` is a struct of size 6.
    static let arrayOfStruct_6 = BL_IMPL_TYPE_ARRAY_STRUCT_6
    
    /// Type is `BLArray<T>` where `T` is a struct of size 8.
    static let arrayOfStruct_8 = BL_IMPL_TYPE_ARRAY_STRUCT_8
    
    /// Type is `BLArray<T>` where `T` is a struct of size 10.
    static let arrayOfStruct_10 = BL_IMPL_TYPE_ARRAY_STRUCT_10
    
    /// Type is `BLArray<T>` where `T` is a struct of size 12.
    static let arrayOfStruct_12 = BL_IMPL_TYPE_ARRAY_STRUCT_12
    
    /// Type is `BLArray<T>` where `T` is a struct of size 16.
    static let arrayOfStruct_16 = BL_IMPL_TYPE_ARRAY_STRUCT_16
    
    /// Type is `BLArray<T>` where `T` is a struct of size 20.
    static let arrayOfStruct_20 = BL_IMPL_TYPE_ARRAY_STRUCT_20
    
    /// Type is `BLArray<T>` where `T` is a struct of size 24.
    static let arrayOfStruct_24 = BL_IMPL_TYPE_ARRAY_STRUCT_24
    
    /// Type is `BLArray<T>` where `T` is a struct of size 32.
    static let arrayOfStruct_32 = BL_IMPL_TYPE_ARRAY_STRUCT_32
    
    /// Type is `BLPath`.
    static let path = BL_IMPL_TYPE_PATH
    
    /// Type is `BLRegion`.
    static let region = BL_IMPL_TYPE_REGION
    
    /// Type is `BLImage`.
    static let image = BL_IMPL_TYPE_IMAGE
    
    /// Type is `BLImageCodec`.
    static let imageCodec = BL_IMPL_TYPE_IMAGE_CODEC
    
    /// Type is `BLImageDecoder`.
    static let imageDecoder = BL_IMPL_TYPE_IMAGE_DECODER
    
    /// Type is `BLImageEncoder`.
    static let imageEncoder = BL_IMPL_TYPE_IMAGE_ENCODER
    
    /// Type is `BLGradient`.
    static let gradient = BL_IMPL_TYPE_GRADIENT
    
    /// Type is `BLPattern`.
    static let pattern = BL_IMPL_TYPE_PATTERN
    
    /// Type is `BLContext`.
    static let context = BL_IMPL_TYPE_CONTEXT
    
    /// Type is `BLFont`.
    static let font = BL_IMPL_TYPE_FONT
    
    /// Type is `BLFontFace`.
    static let fontFace = BL_IMPL_TYPE_FONT_FACE
    
    /// Type is `BLFontData`.
    static let fontData = BL_IMPL_TYPE_FONT_DATA
    
    /// Type is `BLFontLoader`.
    static let fontLoader = BL_IMPL_TYPE_FONT_LOADER
    
    /// Type is `BLFontFeatureOptions`.
    static let fontFeatureOptions = BL_IMPL_TYPE_FONT_FEATURE_OPTIONS
    
    /// Type is `BLFontVariationOptions`.
    static let fontVariationOptions = BL_IMPL_TYPE_FONT_VARIATION_OPTIONS
}

public extension BLImageCodecFeatures {
    /// Image codec supports reading images (can create BLImageDecoder).
    static let read = BL_IMAGE_CODEC_FEATURE_READ
    /// Image codec supports writing images (can create BLImageEncoder).
    static let write = BL_IMAGE_CODEC_FEATURE_WRITE
    /// Image codec supports lossless compression.
    static let lossless = BL_IMAGE_CODEC_FEATURE_LOSSLESS
    /// Image codec supports loosy compression.
    static let lossy = BL_IMAGE_CODEC_FEATURE_LOSSY
    /// Image codec supports writing multiple frames (GIF).
    static let multiFrame = BL_IMAGE_CODEC_FEATURE_MULTI_FRAME
    /// Image codec supports IPTC metadata.
    static let iptc = BL_IMAGE_CODEC_FEATURE_IPTC
    /// Image codec supports EXIF metadata.
    static let exif = BL_IMAGE_CODEC_FEATURE_EXIF
    /// Image codec supports XMP metadata.
    static let xmp = BL_IMAGE_CODEC_FEATURE_XMP
}

extension BLImageCodecFeatures: OptionSet { }
extension BLPathFlags: OptionSet { }
extension BLContextCreateFlags: OptionSet { }
extension BLContextFlushFlags: OptionSet { }
extension BLGlyphRunFlags: OptionSet { }
extension BLGlyphItemFlags: OptionSet { }
extension BLFontFaceFlags: OptionSet { }
extension BLFontFaceDiagFlags: OptionSet { }
extension BLFormatFlags: OptionSet { }
extension BLFileOpenFlags: OptionSet { }
