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

public extension BLFileOpenFlags {
    /// Opens the file for reading.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_RDONLY` (Posix)
    ///   * `GENERIC_READ` (Windows)
    static let openRead = BL_FILE_OPEN_READ
    
    /// Opens the file for writing:
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_WRONLY` (Posix)
    ///   * `GENERIC_WRITE` (Windows)
    static let openWrite = BL_FILE_OPEN_WRITE
    
    /// Opens the file for reading & writing.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_RDWR` (Posix)
    ///   * `GENERIC_READ | GENERIC_WRITE` (Windows)
    static let openRw = BL_FILE_OPEN_RW
    
    /// Creates the file if it doesn't exist or opens it if it does.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_CREAT` (Posix)
    ///   * `CREATE_ALWAYS` or `OPEN_ALWAYS` depending on other flags (Windows)
    static let openCreate = BL_FILE_OPEN_CREATE
    
    /// Opens the file for deleting or renaming (Windows).
    ///
    /// Adds `DELETE` flag when opening the file to `ACCESS_MASK`.
    static let openDelete = BL_FILE_OPEN_DELETE
    
    /// Truncates the file.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_TRUNC` (Posix)
    ///   * `TRUNCATE_EXISTING` (Windows)
    static let openTruncate = BL_FILE_OPEN_TRUNCATE
    
    /// Opens the file for reading in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_READ` option.
    static let openReadExclusive = BL_FILE_OPEN_READ_EXCLUSIVE
    
    /// Opens the file for writing in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_WRITE` option.
    static let openWriteExclusive = BL_FILE_OPEN_WRITE_EXCLUSIVE
    
    /// Opens the file for both reading and writing (Windows).
    ///
    /// This is a combination of both `BL_FILE_OPEN_READ_EXCLUSIVE` and
    /// `BL_FILE_OPEN_WRITE_EXCLUSIVE`.
    static let openRwExclusive = BL_FILE_OPEN_RW_EXCLUSIVE
    
    /// Creates the file in exclusive mode - fails if the file already exists.
    ///
    /// The following system flags are used when opening the file:
    ///   * `O_EXCL` (Posix)
    ///   * `CREATE_NEW` (Windows)
    static let openCreateExclusive = BL_FILE_OPEN_CREATE_EXCLUSIVE
    
    /// Opens the file for deleting or renaming in exclusive mode (Windows).
    ///
    /// Exclusive mode means to not specify the `FILE_SHARE_DELETE` option.
    static let openDeleteExclusive = BL_FILE_OPEN_DELETE_EXCLUSIVE
}

public extension BLFileSeek {
    /// Seek from the beginning of the file (SEEK_SET).
    static let set = BL_FILE_SEEK_SET
    /// Seek from the current position (SEEK_CUR).
    static let cur = BL_FILE_SEEK_CUR
    /// Seek from the end of the file (SEEK_END).
    static let end = BL_FILE_SEEK_END
}

public extension BLMatrix2DOp {
    /// Reset matrix to identity (argument ignored, should be nullptr).
    static let reset = BL_MATRIX2D_OP_RESET
    /// Assign (copy) the other matrix.
    static let assign = BL_MATRIX2D_OP_ASSIGN
    
    /// Translate the matrix by [x, y].
    static let translate = BL_MATRIX2D_OP_TRANSLATE
    /// Scale the matrix by [x, y].
    static let scale = BL_MATRIX2D_OP_SCALE
    /// Skew the matrix by [x, y].
    static let skew = BL_MATRIX2D_OP_SKEW
    /// Rotate the matrix by the given angle about [0, 0].
    static let rotate = BL_MATRIX2D_OP_ROTATE
    /// Rotate the matrix by the given angle about [x, y].
    static let rotatePt = BL_MATRIX2D_OP_ROTATE_PT
    /// Transform this matrix by other `BLMatrix2D`.
    static let transform = BL_MATRIX2D_OP_TRANSFORM
    
    /// Post-translate the matrix by [x, y].
    static let postTranslate = BL_MATRIX2D_OP_POST_TRANSLATE
    /// Post-scale the matrix by [x, y].
    static let postScale = BL_MATRIX2D_OP_POST_SCALE
    /// Post-skew the matrix by [x, y].
    static let postSkew = BL_MATRIX2D_OP_POST_SKEW
    /// Post-rotate the matrix about [0, 0].
    static let postRotate = BL_MATRIX2D_OP_POST_ROTATE
    /// Post-rotate the matrix about a reference BLPoint.
    static let postRotatePt = BL_MATRIX2D_OP_POST_ROTATE_PT
    /// Post-transform this matrix by other `BLMatrix2D`.
    static let postTransform = BL_MATRIX2D_OP_POST_TRANSFORM
}

public extension BLGradientType {
    /// Linear gradient type.
    static let linear = BL_GRADIENT_TYPE_LINEAR
    /// Radial gradient type.
    static let radial = BL_GRADIENT_TYPE_RADIAL
    /// Conical gradient type.
    static let conical = BL_GRADIENT_TYPE_CONICAL
}

public extension BLExtendMode {
    /// Pad extend [default].
    static let pad = BL_EXTEND_MODE_PAD
    /// Repeat extend.
    static let `repeat` = BL_EXTEND_MODE_REPEAT
    /// Reflect extend.
    static let reflect = BL_EXTEND_MODE_REFLECT
    
    /// Alias to `BL_EXTEND_MODE_PAD`.
    static let padXPadY = BL_EXTEND_MODE_PAD_X_PAD_Y
    /// Alias to `BL_EXTEND_MODE_REPEAT`.
    static let repeatXRepeatY = BL_EXTEND_MODE_REPEAT_X_REPEAT_Y
    /// Alias to `BL_EXTEND_MODE_REFLECT`.
    static let reflectXReflectY = BL_EXTEND_MODE_REFLECT_X_REFLECT_Y
    /// Pad X and repeat Y.
    static let padXRepeatY = BL_EXTEND_MODE_PAD_X_REPEAT_Y
    /// Pad X and reflect Y.
    static let padXReflectY = BL_EXTEND_MODE_PAD_X_REFLECT_Y
    /// Repeat X and pad Y.
    static let repeatXPadY = BL_EXTEND_MODE_REPEAT_X_PAD_Y
    /// Repeat X and reflect Y.
    static let repeatXReflectY = BL_EXTEND_MODE_REPEAT_X_REFLECT_Y
    /// Reflect X and pad Y.
    static let reflectXPadY = BL_EXTEND_MODE_REFLECT_X_PAD_Y
    /// Reflect X and repeat Y.
    static let reflectXRepeatY = BL_EXTEND_MODE_REFLECT_X_REPEAT_Y
}

public extension BLRuntimeInfoType {
    /// Blend2D build information.
    static let build = BL_RUNTIME_INFO_TYPE_BUILD
    /// System information (includes CPU architecture, features, cores, etc...).
    static let memory = BL_RUNTIME_INFO_TYPE_MEMORY
    /// Runtime information regarding memory used, reserved, etc...
    static let system = BL_RUNTIME_INFO_TYPE_SYSTEM
}

public extension BLBooleanOp {
    /// Result = B.
    static let copy = BL_BOOLEAN_OP_COPY
    /// Result = A & B.
    static let and = BL_BOOLEAN_OP_AND
    /// Result = A | B.
    static let or = BL_BOOLEAN_OP_OR
    /// Result = A ^ B.
    static let xor = BL_BOOLEAN_OP_XOR
    /// Result = A - B.
    static let sub = BL_BOOLEAN_OP_SUB
}

public extension BLRegionType {
    /// Region is empty (has no rectangles).
    static let empty = BL_REGION_TYPE_EMPTY
    /// Region has one rectangle (rectangular).
    static let rect = BL_REGION_TYPE_RECT
    /// Region has more YX sorted rectangles.
    static let complex = BL_REGION_TYPE_COMPLEX
}

public extension BLMatrix2DType {
    /// Identity matrix.
    static let identity = BL_MATRIX2D_TYPE_IDENTITY
    /// Has translation part (the rest is like identity).
    static let translate = BL_MATRIX2D_TYPE_TRANSLATE
    /// Has translation and scaling parts.
    static let scale = BL_MATRIX2D_TYPE_SCALE
    /// Has translation and scaling parts, however scaling swaps X/Y.
    static let swap = BL_MATRIX2D_TYPE_SWAP
    /// Generic affine matrix.
    static let affine = BL_MATRIX2D_TYPE_AFFINE
    /// Invalid/degenerate matrix not useful for transformations.
    static let invalid = BL_MATRIX2D_TYPE_INVALID
}

public extension BLImplTraits {
    /// The data this container holds is mutable if `refCount == 1`.
    static let mutable = BL_IMPL_TRAIT_MUTABLE
    /// The data this container holds is always immutable.
    static let immutable = BL_IMPL_TRAIT_IMMUTABLE
    /// Set if the impl uses an external data (data is not part of impl).
    static let external = BL_IMPL_TRAIT_EXTERNAL
    /// Set if the impl was not allocated by `blRuntimeAllocImpl()`.
    static let foreign = BL_IMPL_TRAIT_FOREIGN
    /// Set if the impl provides a virtual function table (first member).
    static let virt = BL_IMPL_TRAIT_VIRT
    /// Set if the impl is a built-in null instance (default constructed).
    static let null = BL_IMPL_TRAIT_NULL
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
extension BLFileReadFlags: OptionSet { }
