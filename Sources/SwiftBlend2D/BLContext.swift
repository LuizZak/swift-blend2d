import blend2d

public class BLContext: BLBaseClass<BLContextCore> {

    /// Returns target size in abstract units (pixels in case of `BLImage`).
    @inlinable
    public var targetSize: BLSize {
        var size = BLSize.zero
        blContextGetTargetSize(&object, &size)
        return size
    }
    /// Returns target width in abstract units (pixels in case of `BLImage`).
    @inlinable
    public var targetWidth: Double {
        return targetSize.w
    }
    /// Returns target height in abstract units (pixels in case of `BLImage`).
    @inlinable
    public var targetHeight: Double {
        return targetSize.h
    }
    
    /// Returns the target image or null if there is no target image.
    ///
    /// - note: The rendering context doesn't own the image, but it increases its
    /// writer count, which means that the image will not be destroyed even when
    /// user destroys it during the rendering (in such case it will be destroyed
    /// after the rendering ends when the writer count goes to zero). This means
    /// that the rendering context must hold the image and not the pointer to
    /// the `BLImage` passed to either the constructor or `begin()` function. So
    /// the returned pointer is not the same as the pointer passed to `begin()`,
    /// but it points to the same impl.
    public var targetImage: BLImage? {
        if let img = blContextGetTargetImage(&object) {
            return BLImage(weakAssign: img.pointee)
        }
        
        return nil
    }

    /// Returns the type of this context.
    @inlinable
    public var contextType: BLContextType {
        return blContextGetType(&object)
    }

    /// Returns meta-matrix.
    ///
    /// Meta matrix is a core transformation matrix that is normally not changed
    /// by transformations applied to the context. Instead it acts as a secondary
    /// matrix used to create the final transformation matrix from meta and user
    /// matrices.
    ///
    /// Meta matrix can be used to scale the whole context for HI-DPI rendering
    /// or to change the orientation of the image being rendered, however, the
    /// number of use-cases is unlimited.
    ///
    /// To change the meta-matrix you must first change user-matrix and then call
    /// `userToMeta()`, which would update meta-matrix and clear user-matrix.
    ///
    /// See `userMatrix` and `userToMeta()`.
    @inlinable
    public var metaMatrix: BLMatrix2D {
        return object.impl.state.pointee.metaMatrix
    }

    /// Returns user-matrix.
    ///
    /// User matrix contains all transformations that happened to the rendering
    /// context unless the context was restored or `userToMeta()` was called.
    @inlinable
    public var userMatrix: BLMatrix2D {
        return object.impl.state.pointee.userMatrix
    }

    /// Returns rendering hints.
    @inlinable
    public var hints: BLContextHints {
        return object.impl.state.pointee.hints
    }


    /// Gets or sets the tolerance used for curve flattening.
    @inlinable
    public var flattenTolerance: Double {
        get {
            return object.impl.state.pointee.approximationOptions.flattenTolerance
        }
        set {
            blContextSetFlattenTolerance(&object, newValue)
        }
    }

    /// Gets or sets the flatten mode (how curves are flattened).
    @inlinable
    public var flattenMode: BLFlattenMode {
        get {
            return BLFlattenMode(BLFlattenMode.RawValue(object.impl.state.pointee.approximationOptions.flattenMode))
        }
        set {
            blContextSetFlattenMode(&object, newValue)
        }
    }

    /// Gets or sets the composition operator.
    @inlinable
    public var compOp: BLCompOp {
        get {
            return BLCompOp(BLCompOp.RawValue(object.impl.state.pointee.compOp))
        }
        set {
            blContextSetCompOp(&object, newValue)
        }
    }

    /// Gets or sets the global alpha value.
    @inlinable
    public var globalAlpha: Double {
        get {
            return object.impl.state.pointee.globalAlpha
        }
        set {
            blContextSetGlobalAlpha(&object, newValue)
        }
    }
    
    @inlinable
    public var fillStyleType: UInt32 {
        assert(BLContextOpType.fill.rawValue == 0)
        return UInt32(object.impl.state.pointee.styleType.0)
    }
    
    @inlinable
    public var strokeStyleType: UInt32 {
        assert(BLContextOpType.stroke.rawValue == 1)
        return UInt32(object.impl.state.pointee.styleType.1)
    }
    
    /// Gets an enumeration specifying the fill style and their current associated
    /// values.
    public var fillStyle: OpStyle {
        let value = BLVar {
            blContextGetFillStyle(&object, $0)
        }

        switch value.type {
        case .null:
            return .none
        case .rgba:
            return .solid(value.typed(as: BLRgba.self).value)
        case .gradient:
            let box = BLBaseClass(weakAssign: value.unsafeCast(to: BLGradientCore.self))

            return .gradient(BLGradient(box: box))
        case .pattern:
            let box = BLBaseClass(weakAssign: value.unsafeCast(to: BLPatternCore.self))

            return .pattern(BLPattern(box: box))
        default:
            return .none
        }
    }
    
    /// Gets or sets the fill-rule.
    @inlinable
    public var fillRule: BLFillRule {
        get {
            return BLFillRule(BLFillRule.RawValue(object.impl.state.pointee.fillRule))
        }
        set {
            blContextSetFillRule(&object, newValue)
        }
    }
    
    /// Gets or sets fill alpha value.
    @inlinable
    public var fillAlpha: Double {
        get {
            assert(BL_CONTEXT_OP_TYPE_STROKE.rawValue == 0)
            return object.impl.state.pointee.styleAlpha.0
        }
        set {
            blContextSetFillAlpha(&object, newValue)
        }
    }
    
    /// Gets an enumeration specifying the stroke style and their current associated
    /// values.
    public var strokeStyle: OpStyle {
        let value = BLVar {
            blContextGetStrokeStyle(&object, $0)
        }

        switch value.type {
        case .null:
            return .none
        case .rgba:
            return .solid(value.typed(as: BLRgba.self).value)
        case .gradient:
            let box = BLBaseClass(weakAssign: value.unsafeCast(to: BLGradientCore.self))

            return .gradient(BLGradient(box: box))
        case .pattern:
            let box = BLBaseClass(weakAssign: value.unsafeCast(to: BLPatternCore.self))

            return .pattern(BLPattern(box: box))
        default:
            return .none
        }
    }
    
    /// Gets or sets stroke alpha value.
    @inlinable
    public var strokeAlpha: Double {
        get {
            assert(BL_CONTEXT_OP_TYPE_STROKE.rawValue == 1)
            return object.impl.state.pointee.styleAlpha.1
        }
        set {
            blContextSetStrokeAlpha(&object, newValue)
        }
    }

    @inlinable
    public override init() {
        super.init()
    }
    
    /// Initializes a new context that draws on a given image.
    ///
    /// Returns nil, in case an invalid image state was provided.
    ///
    /// - Parameters:
    ///   - image: The image to draw on. If the image is empty (with default
    /// constructor `BLImage.init()`), the initialization fails.
    ///   - options: Options to use when creating the new context.
    @inlinable
    public init?(image: BLImage, options: CreateOptions? = nil) {
        let options = options?.toBLContextCreateInfo()
        
        super.init { objectPtr in
            try? resultToError(
                withUnsafeNullablePointer(to: options) {
                    blContextInitAs(objectPtr, &image.object, $0)
                }
            )
        }
    }
    
    /// Begins rendering to the given `image`.
    ///
    /// If this operation succeeds then the rendering context will have exclusive
    /// access to the image data. This means that no other renderer can use it
    /// during rendering.
    @discardableResult
    public func begin(image: BLImage, options: CreateOptions? = nil) -> BLResult {
        let options = options?.toBLContextCreateInfo()
        
        return withUnsafeNullablePointer(to: options) {
            blContextBegin(&object, &image.object, $0)
        }
    }
    
    /// Waits for completion of all render commands and detaches the rendering
    /// context from the rendering target. After `end()` completes the rendering
    /// context implementation would be released and replaced by a built-in null
    /// instance (no context).
    @discardableResult
    @inlinable
    public func end() -> BLResult {
        return blContextEnd(&object)
    }

    /// Store the result of combining the current `MetaMatrix` and `UserMatrix`
    /// to `MetaMatrix` and reset `UserMatrix` to identity as shown below:
    ///
    /// ```
    /// MetaMatrix = MetaMatrix x UserMatrix
    /// UserMatrix = Identity
    /// ```
    ///
    /// Please note that this operation is irreversible. The only way to restore
    /// both matrices to the state before the call to `userToMeta()` is to use
    /// `save()` and `restore()` functions.
    @discardableResult
    @inlinable
    public func userToMeta() -> BLResult {
        return blContextUserToMeta(&object)
    }

    @discardableResult
    @inlinable
    public func setRenderingQualityHint(_ value: BLRenderingQuality) -> BLResult {
        return blContextSetHint(&object, .renderingQuality, UInt32(value.rawValue))
    }

    @discardableResult
    @inlinable
    public func setGradientQualityHint(_ value: BLGradientQuality) -> BLResult {
        return blContextSetHint(&object, .gradientQuality, UInt32(value.rawValue))
    }

    @discardableResult
    @inlinable
    public func setPatternQualityHint(_ value: BLPatternQuality) -> BLResult {
        return blContextSetHint(&object, .patternQuality, UInt32(value.rawValue))
    }

    @discardableResult
    @inlinable
    public func setApproximationOptions(_ value: BLApproximationOptions) -> BLResult {
        var value = value
        return blContextSetApproximationOptions(&object, &value)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ gradient: BLGradient) -> BLResult {
        return blContextSetFillStyle(&object, &gradient.box.object)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ pattern: BLPattern) -> BLResult {
        return blContextSetFillStyle(&object, &pattern.box.object)
    }

    @discardableResult
    @inlinable
    public func setFillStyleRgba32(_ value: UInt32) -> BLResult {
        return blContextSetFillStyleRgba32(&object, value)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ value: BLRgba32) -> BLResult {
        return blContextSetFillStyleRgba32(&object, value.value)
    }

    @discardableResult
    @inlinable
    public func setFillStyleRgba64(_ value: UInt64) -> BLResult {
        return blContextSetFillStyleRgba64(&object, value)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ value: BLRgba64) -> BLResult {
        return blContextSetFillStyleRgba64(&object, value.value)
    }
    
    /// Sets stroke width to `width`.
    @discardableResult
    public func setStrokeWidth(_ width: Double) -> BLResult {
        return blContextSetStrokeWidth(&object, width)
    }
    
    /// Sets miter limit to `miterLimit`.
    @discardableResult
    @inlinable
    public func setStrokeMiterLimit(_ miterLimit: Double) -> BLResult {
        return blContextSetStrokeMiterLimit(&object, miterLimit)
    }
    
    /// Sets stroke cap of the specified `type` to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeCap(_ position: BLStrokeCapPosition, strokeCap: BLStrokeCap) -> BLResult {
        return blContextSetStrokeCap(&object, position, strokeCap)
    }
    
    /// Sets all stroke caps to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeCaps(_ strokeCap: BLStrokeCap) -> BLResult {
        return blContextSetStrokeCaps(&object, strokeCap)
    }
    
    /// Sets stroke start cap to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeStartCap(_ strokeCap: BLStrokeCap) -> BLResult {
        return setStrokeCap(.start, strokeCap: strokeCap)
    }
    /// Sets stroke end cap to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeEndCap(_ strokeCap: BLStrokeCap) -> BLResult {
        return setStrokeCap(.end, strokeCap: strokeCap)
    }

    @discardableResult
    @inlinable
    public func setStrokeJoin(_ strokeJoin: BLStrokeJoin) -> BLResult {
        return blContextSetStrokeJoin(&object, strokeJoin)
    }
    
    /// Sets stroke dash-offset to `dashOffset`.
    @discardableResult
    @inlinable
    public func setStrokeDashOffset(_ dashOffset: Double) -> BLResult {
        return blContextSetStrokeDashOffset(&object, dashOffset)
    }
    
    /// Sets stroke dash-array to `dashArray`.
    @discardableResult
    public func setStrokeDashArray(_ dashArray: [Double]) -> BLResult {
        let array = BLArray(array: dashArray)
        return blContextSetStrokeDashArray(&object, &array.object)
    }
    
    /// Sets stroke transformation order to `transformOrder`.
    @discardableResult
    @inlinable
    public func setStrokeTransformOrder(_ transformOrder: BLStrokeTransformOrder) -> BLResult {
        return blContextSetStrokeTransformOrder(&object, transformOrder)
    }
    
    /// Sets all stroke `options`.
    @discardableResult
    @inlinable
    public func setStrokeOptions(_ options: BLStrokeOptions) -> BLResult {
        return blContextSetStrokeOptions(&object, &options.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ rgba32: BLRgba32) -> BLResult {
        return setStrokeStyleRgba32(rgba32.value)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ rgba64: BLRgba64) -> BLResult {
        return setStrokeStyleRgba64(rgba64.value)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ gradient: BLGradient) -> BLResult {
        return blContextSetStrokeStyle(&object, &gradient.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ pattern: BLPattern) -> BLResult {
        return blContextSetStrokeStyle(&object, &pattern.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyleRgba32(_ rgba32: UInt32) -> BLResult {
        return blContextSetStrokeStyleRgba32(&object, rgba32)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyleRgba64(_ rgba64: UInt64) -> BLResult {
        return blContextSetStrokeStyleRgba64(&object, rgba64)
    }

    @discardableResult
    @inlinable
    public func clipToRect(_ rect: BLRectI) -> BLResult {
        var rect = rect
        
        return blContextClipToRectI(&object, &rect)
    }

    @discardableResult
    @inlinable
    public func clipToRect(_ rect: BLRect) -> BLResult {
        var rect = rect
        
        return blContextClipToRectD(&object, &rect)
    }

    @discardableResult
    @inlinable
    public func restoreClipping() -> BLResult {
        return blContextRestoreClipping(&object)
    }

    /// Clears the entire context region.
    @discardableResult
    @inlinable
    public func clearAll() -> BLResult {
        return blContextClearAll(&object)
    }

    /// Clears a rectangle.
    @discardableResult
    @inlinable
    public func clearRect(_ rect: BLRectI) -> BLResult {
        var rect = rect
        
        return blContextClearRectI(&object, &rect)
    }

    /// Clears a rectangle.
    @discardableResult
    @inlinable
    public func clearRect(_ rect: BLRect) -> BLResult {
        var rect = rect
        
        return blContextClearRectD(&object, &rect)
    }
    
    /// Fills everything.
    @discardableResult
    @inlinable
    public func fillAll() -> BLResult {
        return blContextFillAll(&object)
    }

    /// Fills the passed geometry specified by `geometryType` and `geometryData`
    /// [Internal].
    @discardableResult
    @inlinable
    func fillGeometry(_ geometryType: BLGeometryType, _ geometryData: UnsafeRawPointer) -> BLResult {
        return blContextFillGeometry(&object, geometryType, geometryData)
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(x: Int, y: Int, width: Int, height: Int) -> BLResult {
        return fillRect(BLRectI(x: Int32(x), y: Int32(y), w: Int32(width), h: Int32(height)))
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(x: Double, y: Double, width: Double, height: Double) -> BLResult {
        return fillRect(BLRect(x: x, y: y, w: width, h: height))
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(_ rect: BLRectI) -> BLResult {
        var rect = rect
        
        return blContextFillRectI(&object, &rect)
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(_ rect: BLRect) -> BLResult {
        var rect = rect
        
        return blContextFillRectD(&object, &rect)
    }

    /// Fills a box.
    @discardableResult
    @inlinable
    public func fillBox(x0: Int, y0: Int, x1: Int, y1: Int) -> BLResult {
        return fillBox(BLBoxI(x0: Int32(x0), y0: Int32(y0), x1: Int32(x1), y1: Int32(y1)))
    }

    /// Fills a box.
    @discardableResult
    @inlinable
    public func fillBox(x0: Double, y0: Double, x1: Double, y1: Double) -> BLResult {
        return fillBox(BLBox(x0: x0, y0: y0, x1: x1, y1: y1))
    }

    /// Fills a box.
    @discardableResult
    @inlinable
    public func fillBox(_ box: BLBoxI) -> BLResult {
        var box = box

        return fillGeometry(.boxI, &box)
    }

    /// Fills a box.
    @discardableResult
    @inlinable
    public func fillBox(_ box: BLBox) -> BLResult {
        var box = box

        return fillGeometry(.boxD, &box)
    }

    /// Fills a round rect.
    @discardableResult
    @inlinable
    public func fillRoundRect(x: Double, y: Double, width: Double, height: Double, radiusX: Double, radiusY: Double) -> BLResult {
        return fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radiusX, ry: radiusY))
    }

    /// Fills a round rect.
    @discardableResult
    @inlinable
    public func fillRoundRect(x: Double, y: Double, width: Double, height: Double, radius: Double) -> BLResult {
        return fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radius, ry: radius))
    }

    /// Fills a round rect.
    @discardableResult
    @inlinable
    public func fillRoundRect(_ rect: BLRoundRect) -> BLResult {
        return fillGeometry(rect)
    }

    /// Fills a circle.
    @discardableResult
    @inlinable
    public func fillCircle(x: Double, y: Double, radius: Double) -> BLResult {
        return fillCircle(BLCircle(cx: x, cy: y, r: radius))
    }

    /// Fills a circle.
    @discardableResult
    @inlinable
    public func fillCircle(_ circle: BLCircle) -> BLResult {
        var circle = circle
        return fillGeometry(.circle, &circle)
    }

    /// Fills an ellipse.
    @discardableResult
    @inlinable
    public func fillEllipse(_ ellipse: BLEllipse) -> BLResult {
        var ellipse = ellipse
        return fillGeometry(.ellipse, &ellipse)
    }

    /// Fills a chord.
    @discardableResult
    @inlinable
    public func fillChord(_ chord: BLArc) -> BLResult {
        var chord = chord
        return fillGeometry(.chord, &chord)
    }
    /// Fills a chord.
    @discardableResult
    @inlinable
    public func fillChord(cx: Double, cy: Double, r: Double, start: Double, sweep: Double) -> BLResult {
        return fillChord(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Fills a chord.
    @discardableResult
    @inlinable
    public func fillChord(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        return fillChord(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }

    /// Fills a pie.
    @discardableResult
    @inlinable
    public func fillPie(_ pie: BLArc) -> BLResult {
        var pie = pie
        return fillGeometry(.pie, &pie)
    }
    /// Fills a pie.
    @discardableResult
    @inlinable
    public func fillPie(cx: Double, cy: Double, r: Double, start: Double, sweep: Double) -> BLResult {
        return fillPie(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Fills a pie.
    @discardableResult
    @inlinable
    public func fillPie(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        return fillPie(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }

    /// Fills an ellipse.
    @discardableResult
    @inlinable
    public func fillEllipse(x: Double, y: Double, radiusX: Double, radiusY: Double) -> BLResult {
        return fillEllipse(BLEllipse(cx: x, cy: y, rx: radiusX, ry: radiusY))
    }

    /// Fills a triangle.
    @discardableResult
    @inlinable
    public func fillTriangle(_ triangle: BLTriangle) -> BLResult {
        var triangle = triangle
        return fillGeometry(.triangle, &triangle)
    }
    /// Fills a triangle.
    @discardableResult
    @inlinable
    func fillTriangle(p0: BLPoint, p1: BLPoint, p2: BLPoint) -> BLResult {
        return fillTriangle(BLTriangle(p0: p0, p1: p1, p2: p2))
    }
    /// Fills a triangle.
    @discardableResult
    @inlinable
    public func fillTriangle(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return fillTriangle(BLTriangle(x0: x0, y0: y0, x1: x1, y1: y1, x2: x2, y2: y2))
    }

    /// Fills a polygon.
    @discardableResult
    @inlinable
    public func fillPolygon(_ poly: [BLPoint]) -> BLResult {
        return poly.withTemporaryView { poly in
            return fillGeometry(.polygonD, poly)
        }
    }

    /// Fills a polygon.
    @discardableResult
    @inlinable
    public func fillPolygon(_ poly: [BLPointI]) -> BLResult {
        return poly.withTemporaryView { poly in
            return fillGeometry(.polygonI, poly)
        }
    }

    @discardableResult
    @inlinable
    public func fillGeometry(_ roundRect: BLRoundRect) -> BLResult {
        var roundRect = roundRect
        return blContextFillGeometry(&object, .roundRect, &roundRect)
    }

    @discardableResult
    @inlinable
    public func fillText<S: StringProtocol>(_ text: S, at point: BLPointI, font: BLFont) -> BLResult {
        var point = point
        return text.withCString { pointer in
            blContextFillTextI(&object, &point, &font.object, pointer, text.utf8.count, .utf8)
        }
    }

    @discardableResult
    @inlinable
    public func fillText<S: StringProtocol>(_ text: S, at point: BLPoint, font: BLFont) -> BLResult {
        var point = point
        return text.withCString { pointer in
            blContextFillTextD(&object, &point, &font.object, pointer, text.utf8.count, .utf8)
        }
    }

    @discardableResult
    @inlinable
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFont) -> BLResult {
        var point = point
        var glyphRun = glyphRun
        
        return blContextFillGlyphRunI(&object, &point, &font.object, &glyphRun)
    }

    @discardableResult
    @inlinable
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFont) -> BLResult {
        var point = point
        var glyphRun = glyphRun
        
        return blContextFillGlyphRunD(&object, &point, &font.object, &glyphRun)
    }
    
    /// Strokes the passed geometry specified by `geometryType` and `geometryData`
    /// [Internal].
    @inlinable
    @discardableResult
    func strokeGeometry(_ geometryType: BLGeometryType, _ geometryData: UnsafeRawPointer) -> BLResult {
        return blContextStrokeGeometry(&object, geometryType, geometryData)
    }

    @discardableResult
    @inlinable
    public func strokeText<S: StringProtocol>(_ text: S, at point: BLPoint, font: BLFont) -> BLResult {
        var point = point

        return text.withCString { cString -> BLResult in
            return blContextStrokeTextD(&object, &point, &font.object, cString, text.utf8.count, .utf8)
        }
    }
    
    /// Strokes the passed `glyphRun` by using the given `font`.
    @discardableResult
    @inlinable
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFont) -> BLResult {
        var glyphRun = glyphRun
        var point = point
        
        return blContextStrokeGlyphRunI(&object, &point, &font.object, &glyphRun)
    }
    
    /// Strokes the passed `glyphRun` by using the given `font`.
    @discardableResult
    @inlinable
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFont) -> BLResult {
        var glyphRun = glyphRun
        var point = point
        
        return blContextStrokeGlyphRunD(&object, &point, &font.object, &glyphRun)
    }
}

// MARK: - Stroke functions
public extension BLContext {
    /// Strokes a box.
    @discardableResult
    @inlinable
    func strokeBox(_ box: BLBox) -> BLResult {
        var box = box
        return strokeGeometry(.boxD, &box)
    }
    /// Strokes a box.
    @discardableResult
    @inlinable
    func strokeBox(_ box: BLBoxI) -> BLResult {
        var box = box
        return strokeGeometry(.boxI, &box)
    }
    /// Strokes a box.
    @discardableResult
    @inlinable
    func strokeBox(x0: Double, y0: Double, x1: Double, y1: Double) -> BLResult {
        return strokeBox(BLBox(x0: x0, y0: y0, x1: x1, y1: y1))
    }
    /// Strokes a box.
    @discardableResult
    @inlinable
    func strokeBox(x0: Int, y0: Int, x1: Int, y1: Int) -> BLResult {
        return strokeBox(BLBoxI(x0: Int32(x0), y0: Int32(y0), x1: Int32(x1), y1: Int32(y1)))
    }
    
    /// Strokes a rectangle.
    @discardableResult
    @inlinable
    func strokeRect(_ rect: BLRect) -> BLResult {
        var rect = rect
        return blContextStrokeRectD(&object, &rect)
    }
    /// Strokes a rectangle.
    @discardableResult
    @inlinable
    func strokeRect(_ rect: BLRectI) -> BLResult {
        var rect = rect
        return blContextStrokeRectI(&object, &rect)
    }
    /// Strokes a rectangle.
    @discardableResult
    @inlinable
    func strokeRect(x: Double, y: Double, w: Double, h: Double) -> BLResult {
        return strokeRect(BLRect(x: x, y: y, w: w, h: h))
    }
    
    /// Strokes a circle.
    @discardableResult
    @inlinable
    func strokeCircle(_ circle: BLCircle) -> BLResult {
        var circle = circle
        return strokeGeometry(.circle, &circle)
    }
    /// Strokes a circle.
    @discardableResult
    @inlinable
    func strokeCircle(x: Double, y: Double, radius: Double) -> BLResult {
        return strokeCircle(BLCircle(cx: x, cy: y, r: radius))
    }
    
    /// Strokes an ellipse.
    @discardableResult
    @inlinable
    func strokeEllipse(_ ellipse: BLEllipse) -> BLResult {
        var ellipse = ellipse
        return strokeGeometry(.ellipse, &ellipse)
    }
    /// Strokes an ellipse.
    @discardableResult
    @inlinable
    func strokeEllipse(x: Double, y: Double, radiusX: Double, radiusY: Double) -> BLResult {
        return strokeEllipse(BLEllipse(cx: x, cy: y, rx: radiusX, ry: radiusY))
    }
    
    /// Strokes an arc.
    @discardableResult
    @inlinable
    func strokeArc(_ arc: BLArc) -> BLResult {
        var arc = arc
        return strokeGeometry(.arc, &arc)
    }
    /// Strokes an arc.
    @discardableResult
    @inlinable
    func strokeArc(cx: Double, cy: Double, r: Double, start: Double, sweep: Double) -> BLResult {
        return strokeArc(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes an arc.
    @discardableResult
    @inlinable
    func strokeArc(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        return strokeArc(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }
    
    /// Strokes a chord.
    @discardableResult
    @inlinable
    func strokeChord(_ chord: BLArc) -> BLResult {
        var chord = chord
        return strokeGeometry(.chord, &chord)
    }
    /// Strokes a chord.
    @discardableResult
    @inlinable
    func strokeChord(cx: Double, cy: Double, r: Double, start: Double, sweep: Double) -> BLResult {
        return strokeChord(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes a chord.
    @discardableResult
    @inlinable
    func strokeChord(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        return strokeChord(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }
    
    /// Strokes a pie.
    @discardableResult
    @inlinable
    func strokePie(_ pie: BLArc) -> BLResult {
        var pie = pie
        return strokeGeometry(.pie, &pie)
    }
    /// Strokes a pie.
    @discardableResult
    @inlinable
    func strokePie(cx: Double, cy: Double, r: Double, start: Double, sweep: Double) -> BLResult {
        return strokePie(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes a pie.
    @discardableResult
    @inlinable
    func strokePie(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        return strokePie(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }
    
    /// Strokes a triangle.
    @discardableResult
    @inlinable
    func strokeTriangle(_ triangle: BLTriangle) -> BLResult {
        var triangle = triangle
        return strokeGeometry(.triangle, &triangle)
    }
    /// Strokes a triangle.
    @discardableResult
    @inlinable
    func strokeTriangle(p0: BLPoint, p1: BLPoint, p2: BLPoint) -> BLResult {
        return strokeTriangle(BLTriangle(p0: p0, p1: p1, p2: p2))
    }
    /// Strokes a triangle.
    @discardableResult
    @inlinable
    func strokeTriangle(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        return strokeTriangle(BLTriangle(x0: x0, y0: y0, x1: x1, y1: y1, x2: x2, y2: y2))
    }
    
    /// Strokes a polyline.
    @discardableResult
    @inlinable
    func strokePolyline(_ poly: [BLPoint]) -> BLResult {
        return poly.withTemporaryView { poly in
            return strokeGeometry(.polylineD, poly)
        }
    }
    
    /// Strokes a polyline.
    @discardableResult
    @inlinable
    func strokePolyline(_ poly: [BLPointI]) -> BLResult {
        return poly.withTemporaryView { poly in
            return strokeGeometry(.polylineI, poly)
        }
    }
    
    /// Strokes a polygon.
    @discardableResult
    @inlinable
    func strokePolygon(_ poly: [BLPoint]) -> BLResult {
        return poly.withTemporaryView { poly in
            return strokeGeometry(.polygonD, poly)
        }
    }
    
    /// Strokes a polygon.
    @discardableResult
    @inlinable
    func strokePolygon(_ poly: [BLPointI]) -> BLResult {
        return poly.withTemporaryView { poly in
            return strokeGeometry(.polygonI, poly)
        }
    }
    
    /// Strokes an array of boxes.
    @discardableResult
    @inlinable
    func strokeBoxArray(_ array: [BLBox]) -> BLResult {
        return array.withTemporaryView { array in
            return strokeGeometry(.arrayViewBoxD, array)
        }
    }
    
    /// Strokes an array of boxes.
    @discardableResult
    @inlinable
    func strokeBoxArray(_ array: [BLBoxI]) -> BLResult {
        return array.withTemporaryView { array in
            return strokeGeometry(.arrayViewBoxI, array)
        }
    }
    
    /// Strokes an array of rectangles.
    @discardableResult
    @inlinable
    func strokeRectArray(_ array: [BLRect]) -> BLResult {
        return array.withTemporaryView { array in
            return strokeGeometry(.arrayViewRectD, array)
        }
    }
    
    /// Strokes an array of rectangles.
    @discardableResult
    @inlinable
    func strokeRectArray(_ array: [BLRectI]) -> BLResult {
        return array.withTemporaryView { array in
            return strokeGeometry(.arrayViewRectI, array)
        }
    }
    
    /// Strokes a path.
    @discardableResult
    @inlinable
    func strokePath(_ path: BLPath) -> BLResult {
        return strokeGeometry(.path, &path.object)
    }
}

// MARK: - Image blitting
public extension BLContext {
    
    @discardableResult
    @inlinable
    func blitImage(_ image: BLImage, at point: BLPointI, imageArea: BLRectI? = nil) -> BLResult {
        var point = point
        
        return withUnsafeNullablePointer(to: imageArea) {
            blContextBlitImageI(&object, &point, &image.object, $0)
        }
    }
    
    @discardableResult
    @inlinable
    func blitImage(_ image: BLImage, at point: BLPoint, imageArea: BLRectI? = nil) -> BLResult {
        var point = point
        
        return withUnsafeNullablePointer(to: imageArea) {
            blContextBlitImageD(&object, &point, &image.object, $0)
        }
    }
    
    @discardableResult
    @inlinable
    func blitScaledImage(_ image: BLImage, rectangle: BLRectI, imageArea: BLRectI? = nil) -> BLResult {
        var rectangle = rectangle
        
        return withUnsafeNullablePointer(to: imageArea) {
            blContextBlitScaledImageI(&object, &rectangle, &image.object, $0)
        }
    }
    
    @discardableResult
    @inlinable
    func blitScaledImage(_ image: BLImage, rectangle: BLRect, imageArea: BLRectI? = nil) -> BLResult {
        var rectangle = rectangle
        
        return withUnsafeNullablePointer(to: imageArea) {
            blContextBlitScaledImageD(&object, &rectangle, &image.object, $0)
        }
    }
}

public extension BLContext {
    
    @discardableResult
    @inlinable
    func fillPath(_ path: BLPath) -> BLResult {
        return blContextFillPathD(&object, &path.object)
    }
    
}

public extension BLContext {
    
    @inlinable
    func flush(flags: BLContextFlushFlags) {
        blContextFlush(&object, flags)
    }
}

public extension BLContext {
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(_ rr: BLRoundRect) -> BLResult {
        var rr = rr
        return strokeGeometry(.roundRect, &rr)
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(rect: BLRect, radius: Double) -> BLResult {
        return strokeRoundRect(BLRoundRect(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radius, ry: radius))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(rect: BLRect, radiusX: Double, radiusY: Double) -> BLResult {
        return strokeRoundRect(BLRoundRect(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radiusX, ry: radiusY))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(x: Double, y: Double, width: Double, height: Double, radius: Double) -> BLResult {
        return strokeRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radius, ry: radius))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(x: Double, y: Double, width: Double, height: Double, radiusX: Double, radiusY: Double) -> BLResult {
        return strokeRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radiusX, ry: radiusY))
    }
}

public extension BLContext {
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(_ line: BLLine) -> BLResult {
        var line = line
        return strokeGeometry(.line, &line)
    }
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(p0: BLPoint, p1: BLPoint) -> BLResult {
        return strokeLine(BLLine(x0: p0.x, y0: p0.y, x1: p1.x, y1: p1.y))
    }
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(p0: BLPointI, p1: BLPointI) -> BLResult {
        return strokeLine(BLLine(x0: Double(p0.x), y0: Double(p0.y), x1: Double(p1.x), y1: Double(p1.y)))
    }
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(x0: Double, y0: Double, x1: Double, y1: Double) -> BLResult {
        return strokeLine(BLLine(x0: x0, y0: y0, x1: x1, y1: y1))
    }
}

// MARK: - State saving/restoration
public extension BLContext {

    /// Returns the number of saved states in the context (0 means no saved states).
    var savedStateCount: Int {
        return object.impl.state.pointee.savedStateCount
    }

    /// Saves the current rendering context state.
    ///
    /// Blend2D uses optimizations that make `save()` a cheap operation. Only
    /// core values are actually saved in `save()`, others will only be saved if
    /// they are modified. This means that consecutive calls to `save()` and
    /// `restore()` do almost nothing.
    @inlinable
    func save() {
        blContextSave(&object, nil)
    }
    
    /// Saves the current rendering context state, returning a cookie that must
    /// be provided on the next `restore()` call.
    ///
    /// Blend2D uses optimizations that make `save()` a cheap operation. Only
    /// core values are actually saved in `save()`, others will only be saved if
    /// they are modified. This means that consecutive calls to `save()` and
    /// `restore()` do almost nothing.
    @discardableResult
    @inlinable
    func saveWithCookie() -> BLContextCookie {
        var cookie = BLContextCookie()
        blContextSave(&object, &cookie)
        return cookie
    }
    
    /// Restores the top-most saved context-state.
    ///
    /// Possible return conditions:
    ///
    ///   * `BL_SUCCESS` - State was restored successfully.
    ///   * `BL_ERROR_NO_STATES_TO_RESTORE` - There are no saved states to
    ///     restore.
    ///   * `BL_ERROR_NO_MATCHING_COOKIE` - Previous state was saved with
    ///     cookie, which was not provided. You would need the correct cookie to
    ///     restore such state.
    @discardableResult
    @inlinable
    func restore() -> BLResult {
        return blContextRestore(&object, nil)
    }
    
    /// Restores to the point that matches the given `cookie`.
    ///
    /// More than one state can be restored in case that the `cookie` points to
    /// some previous state in the list.
    ///
    /// Possible return conditions:
    ///
    ///   * `BL_SUCCESS` - Matching state was restored successfully.
    ///   * `BL_ERROR_NO_STATES_TO_RESTORE` - There are no saved states to
    ///     restore.
    ///   * `BL_ERROR_NO_MATCHING_COOKIE` - The cookie did't match any saved
    ///      state.
    @discardableResult
    @inlinable
    func restore(from cookie: BLContextCookie) -> BLResult {
        var cookie = cookie
        return blContextRestore(&object, &cookie)
    }
}

public extension BLContext {
    enum OpStyle {
        case none
        case solid(BLRgba)
        case gradient(BLGradient)
        case pattern(BLPattern)
    }
}

public extension BLContext {
    @inlinable
    @discardableResult
    func resetMatrix() -> BLResult {
        return _applyMatrixOp(.reset)
    }
    @inlinable
    @discardableResult
    func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @inlinable
    @discardableResult
    func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @inlinable
    @discardableResult
    func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @inlinable
    @discardableResult
    func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @inlinable
    @discardableResult
    func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @inlinable
    @discardableResult
    func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @inlinable
    @discardableResult
    func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @inlinable
    @discardableResult
    func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @inlinable
    @discardableResult
    func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @inlinable
    @discardableResult
    func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @inlinable
    @discardableResult
    func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @inlinable
    @discardableResult
    func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @inlinable
    @discardableResult
    func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @inlinable
    @discardableResult
    func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    
    @inlinable
    @discardableResult
    func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLContext {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOp(_ opType: BLMatrix2DOp) -> BLResult {
        blContextMatrixOp(&object, opType, nil)
    }

    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blContextMatrixOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blContextMatrixOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            blContextMatrixOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        return args.withUnsafeBytes { pointer in
            blContextMatrixOp(&object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            blContextMatrixOp(&object, opType, pointer.baseAddress)
        }
    }
}

extension BLContextCore: CoreStructure {
    public static let initializer = blContextInit
    public static let deinitializer = blContextReset
    public static let assignWeak = blContextAssignWeak

    @usableFromInline
    var impl: BLContextImpl {
        get {
            _d.impl!.load(as: BLContextImpl.self)
        }
        set {
            _d.impl!.storeBytes(of: newValue, as: BLContextImpl.self)
        }
    }
}
