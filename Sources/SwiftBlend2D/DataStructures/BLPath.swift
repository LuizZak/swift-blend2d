import blend2d

public final class BLPath: BLBaseClass<BLPathCore> {
    /// Returns path capacity (count of allocated vertices).
    @inlinable
    public var capacity: Int {
        return blPathGetCapacity(&object)
    }
    
    /// Returns a bounding box of all vertices and control points.
    ///
    /// Control box is simply bounds of all vertices the path has without further
    /// processing. It contains both on-path and off-path points. Consider using
    /// `boundingBox` if you need a visual bounding box.
    @inlinable
    public var controlBox: BLBox {
        var box = BLBox()
        blPathGetControlBox(&object, &box)
        return box
    }
    
    /// Returns a bounding box of all on-path vertices and curve extremas.
    ///
    /// The bounding box returned could be smaller than a bounding box
    /// obtained by `controlBox` as it's calculated by merging only start/end
    /// points and curves at their extremas (not control points). The resulting
    /// bounding box represents a visual bounds of the path.
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
    
    /// Returns path size (count of vertices used).
    @inlinable
    public var size: Int {
        return blPathGetSize(&object)
    }
    
    /// Gets the last vertex of this path.
    /// Returns the last vertex of the path. If the very last command of the path
    /// is `BLPathCmd.close` then the path will be iterated in reverse order to
    /// match the initial vertex of the last figure.
    /// May return nil, in case no matching vertex could be found.
    @inlinable
    public var lastVertex: BLPoint? {
        var point = BLPoint()
        if blPathGetLastVertex(&object, &point) != BL_SUCCESS.rawValue {
            return nil
        }
        return point
    }

    /// Gets a list of figure ranges on this path.
    @inlinable
    public var figureRanges: [BLRange] {
        var ranges: [BLRange] = []
        var index = 0
        while index < size {
            let range = getFigureRange(index: index)
            ranges.append(range)

            index = range.end
        }
        return ranges
    }
    
    internal init(pointer: UnsafeMutablePointer<BLPathCore>) {
        super.init(weakAssign: pointer.pointee)
    }
    
    public override init() {
        super.init()
    }
    
    /// Gets a new list of paths that each represent a figure within this
    /// path.
    @inlinable
    public func getFigurePaths() -> [BLPath] {
        return figureRanges.map { range in
            let subPath = BLPath()
            subPath.addPath(self, range: range)
            return subPath
        }
    }

    /// Clears the content of the path.
    @discardableResult
    @inlinable
    public func clear() -> BLResult {
        return blPathClear(&object)
    }

    /// Closes the current figure.
    ///
    /// Appends `BLPathCmd.close` to the path.
    ///
    /// Matches SVG 'Z' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataClosePathCommand
    @discardableResult
    @inlinable
    public func close() -> BLResult {
        return blPathClose(&object)
    }

    /// Shrinks the capacity of the path to fit the current usage.
    @discardableResult
    @inlinable
    public func shrink() -> BLResult {
        return blPathShrink(&object)
    }
    
    /// Reserves the capacity of the path for at least `minimumCapacity` vertices and commands.
    @discardableResult
    @inlinable
    public func reserveCapacity(_ minimumCapacity: Int) -> BLResult {
        return blPathReserve(&object, minimumCapacity)
    }

    /// Tests whether this path and the `other` path are equal.
    ///
    /// The equality check is deep. The data of both paths is examined and binary
    /// compared (thus a slight difference like -0 and +0 would make the equality
    /// check to fail).
    @inlinable
    public func equals(to other: BLPath) -> Bool {
        return blPathEquals(&object, &other.object)
    }
    
    /// Sets vertex at `index` to `cmd` and `[pt]`.
    ///
    /// Pass `BLPathCmdExtra.preserve` in `cmd` to preserve the current command.
    @discardableResult
    @inlinable
    public func setVertexAt(index: Int, cmd: UInt32, _ point: BLPoint) -> BLResult {
        return blPathSetVertexAt(&object, index, cmd, point.x, point.y)
    }
    
    /// Sets vertex at `index` to `cmd` and `[x, y]`.
    ///
    /// Pass `BLPathCmdExtra.preserve` in `cmd` to preserve the current command.
    @discardableResult
    @inlinable
    public func setVertexAt(index: Int, cmd: UInt32, x: Double, y: Double) -> BLResult {
        return blPathSetVertexAt(&object, index, cmd, x, y)
    }
    
    /// Moves to `[point]`.
    ///
    /// Appends `BLPathCmd.move[point]` command to the path.
    @discardableResult
    @inlinable
    public func moveTo(_ point: BLPoint) -> BLResult {
        return blPathMoveTo(&object, point.x, point.y)
    }
    
    /// Moves to `[x0, y0]`.
    ///
    /// Appends `BLPathCmd.move[x0, y0]` command to the path.
    @discardableResult
    @inlinable
    public func moveTo(x: Double, y: Double) -> BLResult {
        return blPathMoveTo(&object, x, y)
    }
    
    /// Adds line to `p1`.
    ///
    /// Appends `BLPathCmd.on[point]` command to the path.
    @discardableResult
    @inlinable
    public func lineTo(_ point: BLPoint) -> BLResult {
        return blPathLineTo(&object, point.x, point.y)
    }
    
    /// Adds line to `[x1, y1]`.
    ///
    /// Appends `BLPathCmd.on[x1, y1]` command to the path.
    @discardableResult
    @inlinable
    public func lineTo(x: Double, y: Double) -> BLResult {
        return blPathLineTo(&object, x, y)
    }
    
    /// Adds a polyline (LineTo) of the given `poly` array.
    ///
    /// Appends multiple `BLPathCmd.on[x[i], y[i]]` commands to the path matching the length of `poly`.
    @discardableResult
    @inlinable
    public func polyTo(poly: [BLPoint]) -> BLResult {
        return blPathPolyTo(&object, poly, poly.count)
    }
    
    /// Adds a quadratic curve to `p1` and `p2`.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.quad[p1]`
    ///   - `BLPathCmd.on[p2]`
    ///
    /// Matches SVG 'Q' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataQuadraticBezierCommands
    @discardableResult
    @inlinable
    public func quadTo(_ p1: BLPoint, _ p2: BLPoint) -> BLResult {
        return blPathQuadTo(&object, p1.x, p1.y, p2.x, p2.y)
    }
    
    /// Adds a quadratic curve to `[x1, y1]` and `[x2, y2]`.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.quad[x1, y1]`
    ///   - `BLPathCmd.on[x2, y2]`
    ///
    /// Matches SVG 'Q' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataQuadraticBezierCommands
    @discardableResult
    @inlinable
    public func quadTo(x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return blPathQuadTo(&object, x1, y1, x2, y2)
    }
    
    /// Adds a cubic curve to `p1`, `p2`, `p3`.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.cubic[p1]`
    ///   - `BLPathCmd.cubic[p2]`
    ///   - `BLPathCmd.on[p3]`
    ///
    /// Matches SVG 'C' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataCubicBezierCommands
    @discardableResult
    @inlinable
    public func cubicTo(_ p1: BLPoint, _ p2: BLPoint, _ p3: BLPoint) -> BLResult {
        return blPathCubicTo(&object, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y)
    }
    
    /// Adds a cubic curve to `[x1, y1]`, `[x2, y2]`, and `[x3, y3]`.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.cubic[x1, y1]`
    ///   - `BLPathCmd.cubic[x2, y2]`
    ///   - `BLPathCmd.on[x3, y3]`
    ///
    /// Matches SVG 'C' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataCubicBezierCommands
    @discardableResult
    @inlinable
    public func cubicTo(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) -> BLResult {
        return blPathCubicTo(&object, x1, y1, x2, y2, x3, y3)
    }
    
    /// Adds a smooth quadratic curve to `p2`, calculating `p1` from last points.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.quad[calculated]`
    ///   - `BLPathCmd.on[p2]`
    ///
    /// Matches SVG 'T' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataQuadraticBezierCommands
    @discardableResult
    @inlinable
    public func smoothQuadTo(_ p2: BLPoint) -> BLResult {
        return blPathSmoothQuadTo(&object, p2.x, p2.y)
    }
    
    /// Adds a smooth quadratic curve to `[x2, y2]`, calculating `[x1, y1]` from last points.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.quad[calculated]`
    ///   - `BLPathCmd.on[x2, y2]`
    ///
    /// Matches SVG 'T' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataQuadraticBezierCommands
    @discardableResult
    @inlinable
    public func smoothQuadTo(x2: Double, y2: Double) -> BLResult {
        return blPathSmoothQuadTo(&object, x2, y2)
    }
    
    /// Adds a smooth cubic curve to `p2` and `p3`, calculating `p1` from last points.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.cubic[calculated]`
    ///   - `BLPathCmd.cubic[p2]`
    ///   - `BLPathCmd.on[p3]`
    ///
    /// Matches SVG 'S' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataCubicBezierCommands
    @discardableResult
    @inlinable
    public func smoothCubicTo(_ p2: BLPoint, _ p3: BLPoint) -> BLResult {
        return blPathSmoothCubicTo(&object, p2.x, p2.y, p3.x, p3.y)
    }
    
    /// Adds a smooth cubic curve to `[x2, y2]` and `[x3, y3]`, calculating `[x1, y1]` from last points.
    ///
    /// Appends the following commands to the path:
    ///   - `BLPathCmd.cubic[calculated]`
    ///   - `BLPathCmd.cubic[x2, y2]`
    ///   - `BLPathCmd.on[x3, y3]`
    ///
    /// Matches SVG 'S' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataCubicBezierCommands
    @discardableResult
    @inlinable
    public func smoothCubicTo(x2: Double, y2: Double, x3: Double, y3: Double) -> BLResult {
        return blPathSmoothCubicTo(&object, x2, y2, x3, y3)
    }
    
    /// Adds an arc to the path.
    ///
    /// The center of the arc is specified by `center` and by `radius`. Both `start`
    /// and `sweep` angles are in radians. If the last vertex doesn't match the
    /// start of the arc then a `lineTo()` would be emitted before adding the arc.
    /// Pass `true` in `forceMoveTo` to always emit `moveTo()` at the beginning of
    /// the arc, which starts a new figure.
    @discardableResult
    @inlinable
    public func arcTo(center: BLPoint, radius: BLPoint, start: Double, sweep: Double, forceMoveTo: Bool) -> BLResult {
        return blPathArcTo(&object, center.x, center.y, radius.x, radius.y, start, sweep, forceMoveTo)
    }

    /// Adds an arc to the path.
    ///
    /// The center of the arc is specified by `[x, y]` and by radius `[rx, ry]`. Both `start`
    /// and `sweep` angles are in radians. If the last vertex doesn't match the
    /// start of the arc then a `lineTo()` would be emitted before adding the arc.
    /// Pass `true` in `forceMoveTo` to always emit `moveTo()` at the beginning of
    /// the arc, which starts a new figure.
    @discardableResult
    @inlinable
    public func arcTo(x: Double, y: Double, rx: Double, ry: Double, start: Double, sweep: Double, forceMoveTo: Bool) -> BLResult {
        return blPathArcTo(&object, x, y, rx, ry, start, sweep, forceMoveTo)
    }
    
    /// Adds an arc quadrant (90deg) to the path. The first point `p1` specifies
    /// the quadrant corner and the last point `p2` specifies the end point.
    @discardableResult
    @inlinable
    public func arcQuadrantTo(_ p1: BLPoint, _ p2: BLPoint) -> BLResult {
        return blPathArcQuadrantTo(&object, p1.x, p1.y, p2.x, p2.y)
    }
    
    /// Adds an arc quadrant (90deg) to the path. The first point `[x1, y1]` specifies
    /// the quadrant corner and the last point `[x2, y2]` specifies the end point.
    @discardableResult
    @inlinable
    public func arcQuadrantTo(x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return blPathArcQuadrantTo(&object, x1, y1, x2, y2)
    }
    
    /// Adds an elliptic arc to the path that follows the SVG specification.
    ///
    /// Matches SVG 'A' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands
    @discardableResult
    @inlinable
    public func ellipticArcTo(r: BLPoint,
                              xAxisRotation: Double,
                              largeArcFlag: Bool,
                              sweepFlag: Bool,
                              p1: BLPoint) -> BLResult {
        return blPathEllipticArcTo(&object, r.x, r.y, xAxisRotation, largeArcFlag, sweepFlag, p1.x, p1.y)
    }
    
    /// Adds an elliptic arc to the path that follows the SVG specification.
    ///
    /// Matches SVG 'A' path command:
    ///   - https://www.w3.org/TR/SVG/paths.html#PathDataEllipticalArcCommands
    @discardableResult
    @inlinable
    public func ellipticArcTo(rx: Double,
                              ry: Double,
                              xAxisRotation: Double,
                              largeArcFlag: Bool,
                              sweepFlag: Bool,
                              x1: Double, y1: Double) -> BLResult {
        
        return blPathEllipticArcTo(&object, rx, ry, xAxisRotation, largeArcFlag, sweepFlag, x1, y1)
    }
    
    /// Adds a geometry to the path.
    @discardableResult
    @inlinable
    func addGeometry(_ geometryType: BLGeometryType,
                     _ data: UnsafeRawPointer?,
                     _ matrix: BLMatrix2D?,
                     _ direction: BLGeometryDirection) -> BLResult {

        return withUnsafeNullablePointer(to: matrix) { matrix in
            blPathAddGeometry(&object, geometryType, data, matrix, direction)
        }
    }

    /// Adds a closed circle to the path.
    @inlinable
    @discardableResult
    public func addCircle(_ circle: BLCircle, _ m: BLMatrix2D? = nil, direction: BLGeometryDirection = .cw) -> BLResult {
        var circle = circle

        return addGeometry(.circle, &circle, m, direction)
    }

    /// Adds a closed ellipse to the path.
    @inlinable
    @discardableResult
    public func addEllipse(_ ellipse: BLEllipse, _ m: BLMatrix2D? = nil, direction: BLGeometryDirection = .cw) -> BLResult {
        var ellipse = ellipse

        return addGeometry(.ellipse, &ellipse, m, direction)
    }
    
    /// Adds a closed rectangle to the path specified by `box`.
    @discardableResult
    @inlinable
    public func addBox(_ box: BLBox, direction: BLGeometryDirection = .cw) -> BLResult {
        var box = box

        return blPathAddBoxD(&object, &box, direction)
    }
    
    /// Adds a closed rectangle to the path specified by `box`.
    @discardableResult
    @inlinable
    public func addBox(_ box: BLBoxI, direction: BLGeometryDirection = .cw) -> BLResult {
        var box = box

        return blPathAddBoxI(&object, &box, direction)
    }
    
    /// Adds a closed rectangle to the path specified by `rect`.
    @discardableResult
    @inlinable
    public func addRect(_ rect: BLRect, direction: BLGeometryDirection = .cw) -> BLResult {
        var rect = rect

        return blPathAddRectD(&object, &rect, direction)
    }
    
    /// Adds a closed rectangle to the path specified by `rect`.
    @discardableResult
    @inlinable
    public func addRect(_ rect: BLRectI, direction: BLGeometryDirection = .cw) -> BLResult {
        var rect = rect

        return blPathAddRectI(&object, &rect, direction)
    }
    
    /// Adds a closed rounded ractangle to the path.
    @discardableResult
    @inlinable
    public func addRoundedRect(_ rect: BLRoundRect, _ matrix: BLMatrix2D? = nil, direction: BLGeometryDirection = .cw) -> BLResult {
        var rect = rect
        
        return addGeometry(.roundRect, &rect, matrix, direction)
    }

    /// Adds other `path` sliced by the given `range` to this path.
    /// If `range` is `nil`, the entire path is added.
    @discardableResult
    @inlinable
    public func addPath(_ other: BLPath, range: BLRange? = nil) -> BLResult {
        return withUnsafeNullablePointer(to: range) {
            blPathAddPath(&object, &other.object, $0)
        }
    }

    /// Adds a translated `path` sliced by the given `range` to this path.
    /// If `range` is `nil`, the entire path is added.
    @discardableResult
    @inlinable
    public func addTranslatedPath(_ other: BLPath, offset: BLPoint, range: BLRange? = nil) -> BLResult {
        var offset = offset
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddTranslatedPath(&object, &other.object, $0, &offset)
        }
    }

    /// Adds other `path` sliced by the given `range` and transformed by `matrix` to this path.
    /// If `range` is `nil`, the entire path is added.
    @discardableResult
    @inlinable
    public func addTransformedPath(_ other: BLPath, matrix: BLMatrix2D, range: BLRange? = nil) -> BLResult {
        var matrix = matrix
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddTransformedPath(&object, &other.object, $0, &matrix)
        }
    }

    /// Adds other `path`, but reversed.
    /// If `range` is `nil`, the entire path is added.
    @discardableResult
    @inlinable
    public func addReversedPath(_ other: BLPath,
                                range: BLRange? = nil,
                                reverseMode: BLPathReverseMode = .complete) -> BLResult {
        
        return withUnsafeNullablePointer(to: range) {
            blPathAddReversedPath(&object, &other.object, $0, reverseMode)
        }
    }

    /// Adds a stroke of `path` to this path.
    /// If `range` is `nil`, the entire path is added.
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

    /// Hit tests the given `point` by respecting the given `fillRule`.
    @inlinable
    public func hitTest(point: BLPoint, fillRule: BLFillRule) -> BLHitTest {
        var point = point
        return blPathHitTest(&object, &point, fillRule)
    }
}

public extension BLPath {
    /// Adds a closed rounded rectangle to the path.
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

    /// Adds other `path` translated by `p` and sliced by the given `range` to
    /// this path.
    /// If `range` is `nil`, the entire path is added.
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
    /// If `range` is `nil`, the entire path is added.
    @discardableResult
    @inlinable
    func addPath(_ path: BLPath, transformedBy m: BLMatrix2D, _ range: BLRange? = nil) -> BLResult {
        var m = m
        return withUnsafeNullablePointer(to: range) {
            return blPathAddTransformedPath(&object, &path.object, $0, &m)
        }
    }
}

extension BLPath: Equatable {
    public static func == (lhs: BLPath, rhs: BLPath) -> Bool {
        var rhsObject = rhs.object
        return blPathEquals(&lhs.object, &rhsObject)
    }
}

extension BLPathCore: CoreStructure {
    public static let initializer = blPathInit
    public static let deinitializer = blPathReset
    public static let assignWeak = blPathAssignWeak
}
