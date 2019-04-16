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
