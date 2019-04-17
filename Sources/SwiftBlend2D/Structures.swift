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
