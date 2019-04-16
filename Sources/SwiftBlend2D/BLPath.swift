import blend2d

public final class BLPath: BLBaseClass<BLPathCore> {
    public var capacity: Int {
        return blPathGetCapacity(&object)
    }
    
    public var controlBox: BLBox {
        var box = BLBox()
        blPathGetControlBox(&object, &box)
        return box
    }
    
    public var boundingBox: BLBox {
        var box = BLBox()
        blPathGetBoundingBox(&object, &box)
        return box
    }
    
    public var size: Int {
        return blPathGetSize(&object)
    }
    
    /// Gets the last vertex of this path.
    /// May return nil, in case no matching vertex could be found.
    public var lastVertex: BLPoint? {
        var point = BLPoint()
        if blPathGetLastVertex(&object, &point) != BL_SUCCESS.rawValue {
            return nil
        }
        return point
    }
    
    public override init() {
        super.init()
    }
    
    public func moveTo(x: Double, y: Double) {
        blPathMoveTo(&object, x, y)
    }
    
    public func cubicTo(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        blPathCubicTo(&object, x1, y1, x2, y2, x3, y3)
    }
    
    public func quadTo(x1: Double, y1: Double, x2: Double, y2: Double) {
        blPathQuadTo(&object, x1, y1, x2, y2)
    }
    
    public func reserve(n: Int) {
        blPathReserve(&object, n)
    }
    
    public func setVertexAt(index: Int, cmd: UInt32, x: Double, y: Double) {
        blPathSetVertexAt(&object, index, cmd, x, y)
    }
    
    public func moveTo(x0: Double, y0: Double) {
        blPathMoveTo(&object, x0, y0)
    }
    
    public func lineTo(x1: Double, y1: Double) {
        blPathLineTo(&object, x1, y1)
    }
    
    public func polyTo(poly: [BLPoint]) {
        var poly = poly
        blPathPolyTo(&object, &poly, poly.count)
    }
    
    public func smoothQuadTo(x2: Double, y2: Double) {
        blPathSmoothQuadTo(&object, x2, y2)
    }
    
    public func smoothCubicTo(x2: Double, y2: Double, x3: Double, y3: Double) {
        blPathSmoothCubicTo(&object, x2, y2, x3, y3)
    }
    
    public func arcTo(x: Double, y: Double, rx: Double, ry: Double, start: Double, sweep: Double, forceMoveTo: Bool) {
        blPathArcTo(&object, x, y, rx, ry, start, sweep, forceMoveTo)
    }
    
    public func arcQuadrantTo(x1: Double, y1: Double, x2: Double, y2: Double) {
        blPathArcQuadrantTo(&object, x1, y1, x2, y2)
    }
    
    public func ellipticArcTo(rx: Double, ry: Double, xAxisRotation: Double, largeArcFlag: Bool, sweepFlag: Bool, x1: Double, y1: Double) {
        blPathEllipticArcTo(&object, rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x1, y1)
    }
    
    // TODO: Map blPathAddGeometry
    func addGeometry(/* ... */) {
        
    }
    
    public func addBox(_ box: BLBox, direction: BLGeometryDirection) {
        var box = box
        blPathAddBoxD(&object, &box, direction.rawValue)
    }
    
    public func addBox(_ box: BLBoxI, direction: BLGeometryDirection) {
        var box = box
        blPathAddBoxI(&object, &box, direction.rawValue)
    }
    
    public func addRect(_ rect: BLRect, direction: BLGeometryDirection) {
        var rect = rect
        blPathAddRectD(&object, &rect, direction.rawValue)
    }
    
    public func addRect(_ rect: BLRectI, direction: BLGeometryDirection) {
        var rect = rect
        blPathAddRectI(&object, &rect, direction.rawValue)
    }
    
    public func addPath(_ other: BLPath, range: BLRange? = nil) {
        var range = range
        blPathAddPath(&object, &other.object, makeNullablePointer(&range))
    }
    
    public func addTranslatedPath(_ other: BLPath, offset: BLPoint, range: BLRange? = nil) {
        var offset = offset
        var range = range
        blPathAddTranslatedPath(&object, &other.object, makeNullablePointer(&range), &offset)
    }
    
    public func addTransformedPath(_ other: BLPath, matrix: BLMatrix2D, range: BLRange? = nil) {
        var matrix = matrix
        var range = range
        blPathAddTransformedPath(&object, &other.object, makeNullablePointer(&range), &matrix)
    }
    
    public func addReversedPath(_ other: BLPath, range: BLRange? = nil, reverseMode: BLPathReverseMode = .complete) {
        var range = range
        blPathAddReversedPath(&object, &other.object, makeNullablePointer(&range), reverseMode.rawValue)
    }
    
    public func addStrokedPath(_ other: BLPath, range: BLRange? = nil, options: BLStrokeOptions = BLStrokeOptions(), approximationOptions: BLApproximationOptions? = nil) {
        var range = range
        var approximationOptions = approximationOptions
        blPathAddStrokedPath(&object, &other.object, makeNullablePointer(&range), &options.object, makeNullablePointer(&approximationOptions))
    }
    
    public func translate(by offset: BLPoint, range: BLRange? = nil) {
        var offset = offset
        var range = range
        blPathTranslate(&object, makeNullablePointer(&range), &offset)
    }
    
    public func transform(_ matrix: BLMatrix2D, range: BLRange? = nil) {
        var matrix = matrix
        var range = range
        blPathTransform(&object, makeNullablePointer(&range), &matrix)
    }
    
    // TODO: Add support for flags once Blend2D does so.
    func fitTo(rectangle: BLRect, range: BLRange? = nil) {
        var rectangle = rectangle
        var range = range
        blPathFitTo(&object, makeNullablePointer(&range), &rectangle, 0)
    }
    
    /// Gets the range of a figure at a given index on this path.
    ///
    /// - precondition: index >= 0 && index < size
    public func getFigureRange(index: Int) -> BLRange {
        precondition(index >= 0)
        precondition(index < size)
        
        var range = BLRange()
        blPathGetFigureRange(&object, index, &range)
        
        return range
    }
    
    /// Gets the vertex index on this path that is the closest to a given point.
    public func getClosesVertex(to point: BLPoint, maximumDistance: Double) -> (vertexIndex: Int, distance: Double)? {
        var point = point
        var indexOut = 0
        var distanceOut = 0.0
        
        if blPathGetClosestVertex(&object, &point, maximumDistance, &indexOut, &distanceOut) == BL_SUCCESS.rawValue {
            return nil
        }
        
        if indexOut == SIZE_MAX {
            return nil
        }
        
        return (indexOut, distanceOut)
    }
    
    public func hitTest(point: BLPoint, fillRule: BLFillRule) -> BLHitTest {
        var point = point
        return BLHitTest(blPathHitTest(&object, &point, fillRule.rawValue))
    }
    
    public func clear() {
        blPathClear(&object)
    }
    
    public func close() {
        blPathClose(&object)
    }
    
    public func shrink() {
        blPathShrink(&object)
    }
    
    public func equals(to other: BLPath) -> Bool {
        return blPathEquals(&object, &other.object)
    }
}

extension BLPathCore: CoreStructure {
    public static var initializer = blPathInit
    public static var deinitializer = blPathReset
}
