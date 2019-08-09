import blend2d

public final class BLPath: BLBaseClass<BLPathCore> {
    @inlinable
    public var capacity: Int {
        return blPathGetCapacity(&object)
    }
    
    @inlinable
    public var controlBox: BLBox {
        var box = BLBox()
        blPathGetControlBox(&object, &box)
        return box
    }
    
    @inlinable
    public var boundingBox: BLBox {
        var box = BLBox()
        blPathGetBoundingBox(&object, &box)
        return box
    }
    
    /// Returns the geometric center of this path's bounding box
    @inlinable
    public var center: BLPoint {
        return boundingBox.center
    }
    
    @inlinable
    public var size: Int {
        return blPathGetSize(&object)
    }
    
    /// Gets the last vertex of this path.
    /// May return nil, in case no matching vertex could be found.
    @inlinable
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

    @discardableResult
    @inlinable
    public func moveTo(x: Double, y: Double) -> BLResult {
        return blPathMoveTo(&object, x, y)
    }

    @discardableResult
    @inlinable
    public func lineTo(x: Double, y: Double) -> BLResult {
        return blPathLineTo(&object, x, y)
    }

    @discardableResult
    @inlinable
    public func cubicTo(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) -> BLResult {
        return blPathCubicTo(&object, x1, y1, x2, y2, x3, y3)
    }

    @discardableResult
    @inlinable
    public func quadTo(x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return blPathQuadTo(&object, x1, y1, x2, y2)
    }

    @discardableResult
    @inlinable
    public func reserve(n: Int) -> BLResult {
        return blPathReserve(&object, n)
    }

    @discardableResult
    @inlinable
    public func setVertexAt(index: Int, cmd: UInt32, x: Double, y: Double) -> BLResult {
        return blPathSetVertexAt(&object, index, cmd, x, y)
    }

    @discardableResult
    @inlinable
    public func polyTo(poly: [BLPoint]) -> BLResult {
        return blPathPolyTo(&object, poly, poly.count)
    }

    @discardableResult
    @inlinable
    public func smoothQuadTo(x2: Double, y2: Double) -> BLResult {
        return blPathSmoothQuadTo(&object, x2, y2)
    }

    @discardableResult
    @inlinable
    public func smoothCubicTo(x2: Double, y2: Double, x3: Double, y3: Double) -> BLResult {
        return blPathSmoothCubicTo(&object, x2, y2, x3, y3)
    }

    @discardableResult
    @inlinable
    public func arcTo(x: Double, y: Double, rx: Double, ry: Double, start: Double, sweep: Double, forceMoveTo: Bool) -> BLResult {
        return blPathArcTo(&object, x, y, rx, ry, start, sweep, forceMoveTo)
    }

    @discardableResult
    @inlinable
    public func arcQuadrantTo(x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return blPathArcQuadrantTo(&object, x1, y1, x2, y2)
    }

    @discardableResult
    @inlinable
    public func ellipticArcTo(rx: Double, ry: Double, xAxisRotation: Double, largeArcFlag: Bool, sweepFlag: Bool, x1: Double, y1: Double) -> BLResult {
        return blPathEllipticArcTo(&object, rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x1, y1)
    }

    @discardableResult
    @inlinable
    func addGeometry(_ geometryType: BLGeometryType,
                     _ data: UnsafeRawPointer?,
                     _ matrix: BLMatrix2D?,
                     _ dir: BLGeometryDirection) -> BLResult {

        return withUnsafeNullablePointer(to: matrix) { matrix in
            blPathAddGeometry(&object, geometryType.rawValue, data, matrix, dir.rawValue)
        }
    }

    /// Adds a closed circle to the path.
    @inlinable
    @discardableResult
    public func addCircle(_ circle: BLCircle, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var circle = circle

        return addGeometry(.circle, &circle, m, dir)
    }

    /// Adds a closed ellipse to the path.
    @inlinable
    @discardableResult
    public func addEllipse(_ ellipse: BLEllipse, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var ellipse = ellipse

        return addGeometry(.ellipse, &ellipse, m, dir)
    }

    @discardableResult
    @inlinable
    public func addBox(_ box: BLBox, direction: BLGeometryDirection) -> BLResult {
        var box = box

        return blPathAddBoxD(&object, &box, direction.rawValue)
    }

    @discardableResult
    @inlinable
    public func addBox(_ box: BLBoxI, direction: BLGeometryDirection) -> BLResult {
        var box = box

        return blPathAddBoxI(&object, &box, direction.rawValue)
    }

    @discardableResult
    @inlinable
    public func addRect(_ rect: BLRect, direction: BLGeometryDirection) -> BLResult {
        var rect = rect

        return blPathAddRectD(&object, &rect, direction.rawValue)
    }

    @discardableResult
    @inlinable
    public func addRect(_ rect: BLRectI, direction: BLGeometryDirection) -> BLResult {
        var rect = rect

        return blPathAddRectI(&object, &rect, direction.rawValue)
    }

    /// Adds other `path` sliced by the given `range` to this path.
    @discardableResult
    @inlinable
    public func addPath(_ other: BLPath, range: BLRange? = nil) -> BLResult {
        return withUnsafeNullablePointer(to: range) {
            blPathAddPath(&object, &other.object, $0)
        }
    }

    @discardableResult
    @inlinable
    public func addTranslatedPath(_ other: BLPath, offset: BLPoint, range: BLRange? = nil) -> BLResult {
        var offset = offset
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddTranslatedPath(&object, &other.object, $0, &offset)
        }
    }

    @discardableResult
    @inlinable
    public func addTransformedPath(_ other: BLPath, matrix: BLMatrix2D, range: BLRange? = nil) -> BLResult {
        var matrix = matrix
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddTransformedPath(&object, &other.object, $0, &matrix)
        }
    }

    @discardableResult
    @inlinable
    public func addReversedPath(_ other: BLPath,
                                range: BLRange? = nil,
                                reverseMode: BLPathReverseMode = .complete) -> BLResult {
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddReversedPath(&object, &other.object, $0, reverseMode.rawValue)
        }
    }

    /// Adds a stroke of `path` to this path.
    @discardableResult
    @inlinable
    public func addStrokedPath(_ other: BLPath,
                               range: BLRange? = nil,
                               options: BLStrokeOptions = BLStrokeOptions(),
                               approximationOptions: BLApproximationOptions? = nil) -> BLResult {
        
        return withUnsafeNullablePointer(to: range) { range in
            withUnsafeNullablePointer(to: approximationOptions) { approx in
                blPathAddStrokedPath(&object, &other.object, range, &options.box.object, approx)
            }
        }
    }

    /// Translates a part of the path specified by the given `range` by `p`.
    @discardableResult
    @inlinable
    public func translate(by offset: BLPoint, range: BLRange? = nil) -> BLResult {
        var offset = offset
        
        return withUnsafeNullablePointer(to: range) {
            blPathTranslate(&object, $0, &offset)
        }
    }

    /// Transforms a part of the path specified by the given `range` by matrix `m`.
    @discardableResult
    @inlinable
    public func transform(_ matrix: BLMatrix2D, range: BLRange? = nil) -> BLResult {
        var matrix = matrix
        
        return withUnsafeNullablePointer(to: range) {
            blPathTransform(&object, $0, &matrix)
        }
    }
    
    /// Fits a parh of the path specified by the given `range` into the given
    /// `rect` by taking into account fit flags passed by `fitFlags`.
    @discardableResult
    @inlinable
    func fitTo(rectangle: BLRect, range: BLRange? = nil) -> BLResult {
        var rectangle = rectangle
        
        return withUnsafeNullablePointer(to: range) {
            blPathFitTo(&object, $0, &rectangle, 0)
        }
    }
    
    /// Gets the range of a figure at a given index on this path.
    ///
    /// - precondition: index >= 0 && index < size
    @discardableResult
    @inlinable
    public func getFigureRange(index: Int) -> BLRange {
        precondition(index >= 0)
        precondition(index < size)
        
        var range = BLRange()
        blPathGetFigureRange(&object, index, &range)
        
        return range
    }
    
    /// Gets the vertex index on this path that is the closest to a given point.
    @inlinable
    public func getClosestVertex(to point: BLPoint, maximumDistance: Double) -> (vertexIndex: Int, distance: Double)? {
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

    @inlinable
    public func hitTest(point: BLPoint, fillRule: BLFillRule) -> BLHitTest {
        var point = point
        return BLHitTest(blPathHitTest(&object, &point, fillRule.rawValue))
    }

    @discardableResult
    @inlinable
    public func clear() -> BLResult {
        return blPathClear(&object)
    }

    @discardableResult
    @inlinable
    public func close() -> BLResult {
        return blPathClose(&object)
    }

    @discardableResult
    @inlinable
    public func shrink() -> BLResult {
        return blPathShrink(&object)
    }

    @inlinable
    public func equals(to other: BLPath) -> Bool {
        return blPathEquals(&object, &other.object)
    }
}

public extension BLPath {
    /// Adds a closed rounded ractangle to the path.
    @discardableResult
    @inlinable
    func addRoundRect(_ rr: BLRoundRect, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var rr = rr
        return addGeometry(.roundRect, &rr, m, dir)
    }

    /// Adds an unclosed arc to the path.
    @discardableResult
    @inlinable
    func addArc(_ arc: BLArc, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var arc = arc
        return addGeometry(.arc, &arc, m, dir)
    }

    /// Adds a closed chord to the path.
    @discardableResult
    @inlinable
    func addChord(_ chord: BLArc, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var chord = chord
        return addGeometry(.chord, &chord, m, dir)
    }

    /// Adds a closed pie to the path.
    @discardableResult
    @inlinable
    func addPie(_ pie: BLArc, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var pie = pie
        return addGeometry(.pie, &pie, m, dir)
    }

    /// Adds an unclosed line to the path.
    @discardableResult
    @inlinable
    func addLine(_ line: BLLine, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var line = line
        return addGeometry(.line, &line, m, dir)
    }

    /// Adds a closed triangle.
    @discardableResult
    @inlinable
    func addTriangle(_ triangle: BLTriangle, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var triangle = triangle
        return addGeometry(.triangle, &triangle, m, dir)
    }

    /// Adds a polyline.
    @discardableResult
    @inlinable
    func addPolyline(_ poly: [BLPointI], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var poly = poly
        return addGeometry(.polylineI, &poly, m, dir)
    }

    /// Adds a polyline.
    @discardableResult
    @inlinable
    func addPolyline(_ poly: [BLPoint], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var poly = poly
        return addGeometry(.polylineD, &poly, m, dir)
    }

    /// Adds a polygon.
    @discardableResult
    @inlinable
    func addPolygon(_ poly: [BLPointI], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var poly = poly
        return addGeometry(.polygonI, &poly, m, dir)
    }

    /// Adds a polygon.
    @discardableResult
    @inlinable
    func addPolygon(_ poly: [BLPoint], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var poly = poly
        return addGeometry(.polygonD, &poly, m, dir)
    }

    /// Adds an array of closed boxes.
    @discardableResult
    @inlinable
    func addBoxArray(_ array: [BLBoxI], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var array = array
        return addGeometry(.arrayViewBoxI, &array, m, dir)
    }

    /// Adds an array of closed boxes.
    @discardableResult
    @inlinable
    func addBoxArray(_ array: [BLBox], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var array = array
        return addGeometry(.arrayViewBoxD, &array, m, dir)
    }

    /// Adds an array of closed rectangles.
    @discardableResult
    @inlinable
    func addRectArray(_ array: [BLRectI], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var array = array
        return addGeometry(.arrayViewRectI, &array, m, dir)
    }

    /// Adds an array of closed rectangles.
    @discardableResult
    @inlinable
    func addRectArray(_ array: [BLRect], _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var array = array
        return addGeometry(.arrayViewRectD, &array, m, dir)
    }

    /// Adds a closed region (converted to set of rectangles).
    @discardableResult
    @inlinable
    func addRegion(_ region: BLRegion, _ m: BLMatrix2D? = nil, _ dir: BLGeometryDirection = .cw) -> BLResult {
        var region = region
        return addGeometry(.region, &region, m, dir)
    }

    /// Adds other `path` translated by `p` and sliced by the given `range` to
    /// this path.
    @discardableResult
    @inlinable
    func addPath(_ path: BLPath, translatedBy p: BLPoint, _ range: BLRange? = nil) -> BLResult {
        var p = p
        return withUnsafeNullablePointer(to: range) {
            return blPathAddTranslatedPath(&object, &path.object, $0, &p)
        }
    }

    /// Adds other `path` transformed by `m` and sliced by the given `range`
    /// to this path.
    @discardableResult
    @inlinable
    func addPath(_ path: BLPath, transformedBy m: BLMatrix2D, _ range: BLRange? = nil) -> BLResult {
        var m = m
        return withUnsafeNullablePointer(to: range) {
            return blPathAddTransformedPath(&object, &path.object, $0, &m)
        }
    }
}

extension BLPathCore: CoreStructure {
    public static let initializer = blPathInit
    public static let deinitializer = blPathReset
    public static var assignWeak = blPathAssignWeak
}
