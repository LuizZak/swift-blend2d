import blend2d

public class BLContext: BLBaseClass<BLContextCore> {
    @usableFromInline
    var _state: BLContextState {
        object.impl.state.pointee
    }

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
        targetSize.w
    }
    /// Returns target height in abstract units (pixels in case of `BLImage`).
    @inlinable
    public var targetHeight: Double {
        targetSize.h
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
        blContextGetType(&object)
    }

    /// Returns meta-transform matrix.
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
    /// See `userTransform` and `userToMeta()`.
    @inlinable
    public var metaTransform: BLMatrix2D {
        var matrix = BLMatrix2D()
        blContextGetMetaTransform(&object, &matrix)
        return matrix
    }

    /// Returns user-transform matrix.
    ///
    /// User matrix contains all transformations that happened to the rendering
    /// context unless the context was restored or `userToMeta()` was called.
    @inlinable
    public var userTransform: BLMatrix2D {
        var matrix = BLMatrix2D()
        blContextGetUserTransform(&object, &matrix)
        return matrix
    }

    /// Returns rendering hints.
    @inlinable
    public var hints: BLContextHints {
        _state.hints
    }


    /// Gets or sets the tolerance used for curve flattening.
    @inlinable
    public var flattenTolerance: Double {
        get {
            _state.approximationOptions.flattenTolerance
        }
        set {
            blContextSetFlattenTolerance(&object, newValue)
        }
    }

    /// Gets or sets the flatten mode (how curves are flattened).
    @inlinable
    public var flattenMode: BLFlattenMode {
        get {
            BLFlattenMode(BLFlattenMode.RawValue(_state.approximationOptions.flattenMode))
        }
        set {
            blContextSetFlattenMode(&object, newValue)
        }
    }

    /// Gets or sets the composition operator.
    @inlinable
    public var compOp: BLCompOp {
        get { blContextGetCompOp(&object) }
        set { blContextSetCompOp(&object, newValue) }
    }

    /// Gets or sets the global alpha value.
    @inlinable
    public var globalAlpha: Double {
        get { blContextGetGlobalAlpha(&object) }
        set { blContextSetGlobalAlpha(&object, newValue) }
    }
    
    /* TODO: BLContextOpType was removed or refactored; remove fill/strokeStyleType as well?
    @inlinable
    public var fillStyleType: UInt32 {
        assert(BLContextOpType.fill.rawValue == 0)
        return UInt32(_state.styleType.0)
    }
    
    @inlinable
    public var strokeStyleType: UInt32 {
        assert(BLContextOpType.stroke.rawValue == 1)
        return UInt32(_state.styleType.1)
    }
    */
    
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
            blContextGetFillRule(&object)
        }
        set {
            blContextSetFillRule(&object, newValue)
        }
    }
    
    /// Gets or sets fill alpha value.
    @inlinable
    public var fillAlpha: Double {
        get { blContextGetFillAlpha(&object) }
        set { blContextSetFillAlpha(&object, newValue) }
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
        get { blContextGetStrokeAlpha(&object) }
        set { blContextSetStrokeAlpha(&object, newValue) }
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
        blContextEnd(&object)
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
        blContextUserToMeta(&object)
    }

    @discardableResult
    @inlinable
    public func setRenderingQualityHint(_ value: BLRenderingQuality) -> BLResult {
        blContextSetHint(&object, .renderingQuality, UInt32(value.rawValue))
    }

    @discardableResult
    @inlinable
    public func setGradientQualityHint(_ value: BLGradientQuality) -> BLResult {
        blContextSetHint(&object, .gradientQuality, UInt32(value.rawValue))
    }

    @discardableResult
    @inlinable
    public func setPatternQualityHint(_ value: BLPatternQuality) -> BLResult {
        blContextSetHint(&object, .patternQuality, UInt32(value.rawValue))
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
        blContextSetFillStyle(&object, &gradient.box.object)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ pattern: BLPattern) -> BLResult {
        blContextSetFillStyle(&object, &pattern.box.object)
    }

    @discardableResult
    @inlinable
    public func setFillStyleRgba32(_ value: UInt32) -> BLResult {
        blContextSetFillStyleRgba32(&object, value)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ value: BLRgba32) -> BLResult {
        blContextSetFillStyleRgba32(&object, value.value)
    }

    @discardableResult
    @inlinable
    public func setFillStyleRgba64(_ value: UInt64) -> BLResult {
        blContextSetFillStyleRgba64(&object, value)
    }

    @discardableResult
    @inlinable
    public func setFillStyle(_ value: BLRgba64) -> BLResult {
        blContextSetFillStyleRgba64(&object, value.value)
    }
    
    /// Sets stroke width to `width`.
    @discardableResult
    public func setStrokeWidth(_ width: Double) -> BLResult {
        blContextSetStrokeWidth(&object, width)
    }
    
    /// Sets miter limit to `miterLimit`.
    @discardableResult
    @inlinable
    public func setStrokeMiterLimit(_ miterLimit: Double) -> BLResult {
        blContextSetStrokeMiterLimit(&object, miterLimit)
    }
    
    /// Sets stroke cap of the specified `type` to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeCap(_ position: BLStrokeCapPosition, strokeCap: BLStrokeCap) -> BLResult {
        blContextSetStrokeCap(&object, position, strokeCap)
    }
    
    /// Sets all stroke caps to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeCaps(_ strokeCap: BLStrokeCap) -> BLResult {
        blContextSetStrokeCaps(&object, strokeCap)
    }
    
    /// Sets stroke start cap to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeStartCap(_ strokeCap: BLStrokeCap) -> BLResult {
        setStrokeCap(.start, strokeCap: strokeCap)
    }
    /// Sets stroke end cap to `strokeCap`.
    @discardableResult
    @inlinable
    public func setStrokeEndCap(_ strokeCap: BLStrokeCap) -> BLResult {
        setStrokeCap(.end, strokeCap: strokeCap)
    }

    @discardableResult
    @inlinable
    public func setStrokeJoin(_ strokeJoin: BLStrokeJoin) -> BLResult {
        blContextSetStrokeJoin(&object, strokeJoin)
    }
    
    /// Sets stroke dash-offset to `dashOffset`.
    @discardableResult
    @inlinable
    public func setStrokeDashOffset(_ dashOffset: Double) -> BLResult {
        blContextSetStrokeDashOffset(&object, dashOffset)
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
        blContextSetStrokeTransformOrder(&object, transformOrder)
    }
    
    /// Sets all stroke `options`.
    @discardableResult
    @inlinable
    public func setStrokeOptions(_ options: BLStrokeOptions) -> BLResult {
        blContextSetStrokeOptions(&object, &options.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ rgba32: BLRgba32) -> BLResult {
        setStrokeStyleRgba32(rgba32.value)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ rgba64: BLRgba64) -> BLResult {
        setStrokeStyleRgba64(rgba64.value)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ gradient: BLGradient) -> BLResult {
        blContextSetStrokeStyle(&object, &gradient.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyle(_ pattern: BLPattern) -> BLResult {
        blContextSetStrokeStyle(&object, &pattern.box.object)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyleRgba32(_ rgba32: UInt32) -> BLResult {
        blContextSetStrokeStyleRgba32(&object, rgba32)
    }

    @discardableResult
    @inlinable
    public func setStrokeStyleRgba64(_ rgba64: UInt64) -> BLResult {
        blContextSetStrokeStyleRgba64(&object, rgba64)
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
        blContextRestoreClipping(&object)
    }

    /// Clears the entire context region.
    @discardableResult
    @inlinable
    public func clearAll() -> BLResult {
        blContextClearAll(&object)
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
        blContextFillAll(&object)
    }

    /// Fills the passed geometry specified by `geometryType` and `geometryData`
    /// [Internal].
    @discardableResult
    @inlinable
    func fillGeometry(_ geometryType: BLGeometryType, _ geometryData: UnsafeRawPointer) -> BLResult {
        blContextFillGeometry(&object, geometryType, geometryData)
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(x: Int, y: Int, width: Int, height: Int) -> BLResult {
        fillRect(BLRectI(x: Int32(x), y: Int32(y), w: Int32(width), h: Int32(height)))
    }

    /// Fills a rectangle.
    @discardableResult
    @inlinable
    public func fillRect(x: Double, y: Double, width: Double, height: Double) -> BLResult {
        fillRect(BLRect(x: x, y: y, w: width, h: height))
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
        fillBox(BLBoxI(x0: Int32(x0), y0: Int32(y0), x1: Int32(x1), y1: Int32(y1)))
    }

    /// Fills a box.
    @discardableResult
    @inlinable
    public func fillBox(x0: Double, y0: Double, x1: Double, y1: Double) -> BLResult {
        fillBox(BLBox(x0: x0, y0: y0, x1: x1, y1: y1))
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
        fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radiusX, ry: radiusY))
    }

    /// Fills a round rect.
    @discardableResult
    @inlinable
    public func fillRoundRect(x: Double, y: Double, width: Double, height: Double, radius: Double) -> BLResult {
        fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radius, ry: radius))
    }

    /// Fills a round rect.
    @discardableResult
    @inlinable
    public func fillRoundRect(_ rect: BLRoundRect) -> BLResult {
        fillGeometry(rect)
    }

    /// Fills a circle.
    @discardableResult
    @inlinable
    public func fillCircle(x: Double, y: Double, radius: Double) -> BLResult {
        fillCircle(BLCircle(cx: x, cy: y, r: radius))
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
        fillChord(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Fills a chord.
    @discardableResult
    @inlinable
    public func fillChord(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        fillChord(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
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
        fillPie(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Fills a pie.
    @discardableResult
    @inlinable
    public func fillPie(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        fillPie(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
    }

    /// Fills an ellipse.
    @discardableResult
    @inlinable
    public func fillEllipse(x: Double, y: Double, radiusX: Double, radiusY: Double) -> BLResult {
        fillEllipse(BLEllipse(cx: x, cy: y, rx: radiusX, ry: radiusY))
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
        fillTriangle(BLTriangle(p0: p0, p1: p1, p2: p2))
    }
    /// Fills a triangle.
    @discardableResult
    @inlinable
    public func fillTriangle(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        fillTriangle(BLTriangle(x0: x0, y0: y0, x1: x1, y1: y1, x2: x2, y2: y2))
    }

    /// Fills a polygon.
    @discardableResult
    @inlinable
    public func fillPolygon(_ poly: [BLPoint]) -> BLResult {
        poly.withTemporaryView { poly in
            fillGeometry(.polygonD, poly)
        }
    }

    /// Fills a polygon.
    @discardableResult
    @inlinable
    public func fillPolygon(_ poly: [BLPointI]) -> BLResult {
        poly.withTemporaryView { poly in
            fillGeometry(.polygonI, poly)
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
            blContextFillUtf8TextI(&object, &point, &font.object, pointer, text.utf8.count)
        }
    }

    @discardableResult
    @inlinable
    public func fillText<S: StringProtocol>(_ text: S, at point: BLPoint, font: BLFont) -> BLResult {
        var point = point
        return text.withCString { pointer in
            blContextFillUtf8TextD(&object, &point, &font.object, pointer, text.utf8.count)
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
        blContextStrokeGeometry(&object, geometryType, geometryData)
    }

    @discardableResult
    @inlinable
    public func strokeText<S: StringProtocol>(_ text: S, at point: BLPoint, font: BLFont) -> BLResult {
        var point = point

        return text.withCString { cString -> BLResult in
            blContextStrokeUtf8TextD(&object, &point, &font.object, cString, text.utf8.count)
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
        strokeBox(BLBox(x0: x0, y0: y0, x1: x1, y1: y1))
    }
    /// Strokes a box.
    @discardableResult
    @inlinable
    func strokeBox(x0: Int, y0: Int, x1: Int, y1: Int) -> BLResult {
        strokeBox(BLBoxI(x0: Int32(x0), y0: Int32(y0), x1: Int32(x1), y1: Int32(y1)))
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
        strokeRect(BLRect(x: x, y: y, w: w, h: h))
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
        strokeCircle(BLCircle(cx: x, cy: y, r: radius))
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
        strokeEllipse(BLEllipse(cx: x, cy: y, rx: radiusX, ry: radiusY))
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
        strokeArc(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes an arc.
    @discardableResult
    @inlinable
    func strokeArc(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        strokeArc(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
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
        strokeChord(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes a chord.
    @discardableResult
    @inlinable
    func strokeChord(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        strokeChord(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
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
        strokePie(BLArc(cx: cx, cy: cy, rx: r, ry: r, start: start, sweep: sweep))
    }
    /// Strokes a pie.
    @discardableResult
    @inlinable
    func strokePie(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) -> BLResult {
        strokePie(BLArc(cx: cx, cy: cy, rx: rx, ry: ry, start: start, sweep: sweep))
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
        strokeTriangle(BLTriangle(p0: p0, p1: p1, p2: p2))
    }
    /// Strokes a triangle.
    @discardableResult
    @inlinable
    func strokeTriangle(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double) -> BLResult {
        strokeTriangle(BLTriangle(x0: x0, y0: y0, x1: x1, y1: y1, x2: x2, y2: y2))
    }
    
    /// Strokes a polyline.
    @discardableResult
    @inlinable
    func strokePolyline(_ poly: [BLPoint]) -> BLResult {
        poly.withTemporaryView { poly in
            strokeGeometry(.polylineD, poly)
        }
    }
    
    /// Strokes a polyline.
    @discardableResult
    @inlinable
    func strokePolyline(_ poly: [BLPointI]) -> BLResult {
        poly.withTemporaryView { poly in
            strokeGeometry(.polylineI, poly)
        }
    }
    
    /// Strokes a polygon.
    @discardableResult
    @inlinable
    func strokePolygon(_ poly: [BLPoint]) -> BLResult {
        poly.withTemporaryView { poly in
            strokeGeometry(.polygonD, poly)
        }
    }
    
    /// Strokes a polygon.
    @discardableResult
    @inlinable
    func strokePolygon(_ poly: [BLPointI]) -> BLResult {
        poly.withTemporaryView { poly in
            strokeGeometry(.polygonI, poly)
        }
    }
    
    /// Strokes an array of boxes.
    @discardableResult
    @inlinable
    func strokeBoxArray(_ array: [BLBox]) -> BLResult {
        array.withTemporaryView { array in
            strokeGeometry(.arrayViewBoxD, array)
        }
    }
    
    /// Strokes an array of boxes.
    @discardableResult
    @inlinable
    func strokeBoxArray(_ array: [BLBoxI]) -> BLResult {
        array.withTemporaryView { array in
            strokeGeometry(.arrayViewBoxI, array)
        }
    }
    
    /// Strokes an array of rectangles.
    @discardableResult
    @inlinable
    func strokeRectArray(_ array: [BLRect]) -> BLResult {
        array.withTemporaryView { array in
            strokeGeometry(.arrayViewRectD, array)
        }
    }
    
    /// Strokes an array of rectangles.
    @discardableResult
    @inlinable
    func strokeRectArray(_ array: [BLRectI]) -> BLResult {
        array.withTemporaryView { array in
            strokeGeometry(.arrayViewRectI, array)
        }
    }
    
    /// Strokes a path.
    @discardableResult
    @inlinable
    func strokePath(_ path: BLPath) -> BLResult {
        strokeGeometry(.path, &path.object)
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
    func fillPath(origin: BLPoint = .zero, _ path: BLPath) -> BLResult {
        var origin = origin
        return blContextFillPathD(&object, &origin, &path.object)
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
        strokeRoundRect(BLRoundRect(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radius, ry: radius))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(rect: BLRect, radiusX: Double, radiusY: Double) -> BLResult {
        strokeRoundRect(BLRoundRect(x: rect.x, y: rect.y, w: rect.w, h: rect.h, rx: radiusX, ry: radiusY))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(x: Double, y: Double, width: Double, height: Double, radius: Double) -> BLResult {
        strokeRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radius, ry: radius))
    }
    /// Strokes a rounded rectangle.
    @discardableResult
    @inlinable
    func strokeRoundRect(x: Double, y: Double, width: Double, height: Double, radiusX: Double, radiusY: Double) -> BLResult {
        strokeRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radiusX, ry: radiusY))
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
        strokeLine(BLLine(x0: p0.x, y0: p0.y, x1: p1.x, y1: p1.y))
    }
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(p0: BLPointI, p1: BLPointI) -> BLResult {
        strokeLine(BLLine(x0: Double(p0.x), y0: Double(p0.y), x1: Double(p1.x), y1: Double(p1.y)))
    }
    /// Strokes a line.
    @discardableResult
    @inlinable
    func strokeLine(x0: Double, y0: Double, x1: Double, y1: Double) -> BLResult {
        strokeLine(BLLine(x0: x0, y0: y0, x1: x1, y1: y1))
    }
}

// MARK: - State saving/restoration
public extension BLContext {

    /// Returns the number of saved states in the context (0 means no saved states).
    var savedStateCount: Int {
        Int(clamping: _state.savedStateCount)
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
        blContextRestore(&object, nil)
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
        _applyTransformOp(.reset)
    }
    @inlinable
    @discardableResult
    func translate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.translate, x, y)
    }
    @inlinable
    @discardableResult
    func translate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.translate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func translate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.translate, p)
    }
    @inlinable
    @discardableResult
    func scale(xy: Double) -> BLResult {
        _applyTransformOpV(.scale, xy, xy)
    }
    @inlinable
    @discardableResult
    func scale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.scale, x, y)
    }
    @inlinable
    @discardableResult
    func scale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.scale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func scale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.scale, p)
    }
    @inlinable
    @discardableResult
    func skew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.skew, x, y)
    }
    @inlinable
    @discardableResult
    func skew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.skew, p)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double) -> BLResult {
        _applyTransformOp(.rotate, angle)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    func rotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @inlinable
    @discardableResult
    func transform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.transform, matrix)
    }
    @inlinable
    @discardableResult
    func postTranslate(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postTranslate, x, y)
    }
    @inlinable
    @discardableResult
    func postTranslate(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postTranslate, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func postTranslate(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postTranslate, p)
    }
    @inlinable
    @discardableResult
    func postScale(xy: Double) -> BLResult {
        _applyTransformOpV(.postScale, xy, xy)
    }
    @inlinable
    @discardableResult
    func postScale(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postScale, x, y)
    }
    @inlinable
    @discardableResult
    func postScale(by p: BLPointI) -> BLResult {
        _applyTransformOpV(.postScale, p.x, p.y)
    }
    @inlinable
    @discardableResult
    func postScale(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postScale, p)
    }
    @inlinable
    @discardableResult
    func postSkew(x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postSkew, x, y)
    }
    @inlinable
    @discardableResult
    func postSkew(by p: BLPoint) -> BLResult {
        _applyTransformOp(.postSkew, p)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double) -> BLResult {
        _applyTransformOp(.postRotate, angle)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, x, y)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, point: BLPoint) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, point.x, point.y)
    }
    @inlinable
    @discardableResult
    func postRotate(angle: Double, point: BLPointI) -> BLResult {
        _applyTransformOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    
    @inlinable
    @discardableResult
    func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        _applyTransformOp(.postTransform, matrix)
    }
}

internal extension BLContext {
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOp(_ opType: BLTransformOp) -> BLResult {
        blContextApplyTransformOp(&object, opType, nil)
    }

    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLMatrix2D) -> BLResult {
        withUnsafePointer(to: opData) { pointer in
            blContextApplyTransformOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOp(_ opType: BLTransformOp, _ opData: BLPoint) -> BLResult {
        withUnsafePointer(to: opData) { pointer in
            blContextApplyTransformOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOp(_ opType: BLTransformOp, _ opData: Double) -> BLResult {
        withUnsafePointer(to: opData) { pointer in
            blContextApplyTransformOp(&object, opType, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOpV(_ opType: BLTransformOp, _ args: Double...) -> BLResult {
        args.withUnsafeBytes { pointer in
            blContextApplyTransformOp(&object, opType, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    @inlinable
    func _applyTransformOpV<T: BinaryInteger>(_ opType: BLTransformOp, _ args: T...) -> BLResult {
        args.map { Double($0) }.withUnsafeBytes { pointer in
            blContextApplyTransformOp(&object, opType, pointer.baseAddress)
        }
    }
}

extension BLContextCore: CoreStructure {
    public static let initializer = blContextInit
    public static let deinitializer = blContextReset
    public static let assignWeak = blContextAssignWeak

    @usableFromInline
    var impl: BLContextImpl {
        get { UnsafeMutablePointer(_d.impl)!.pointee }
        set { UnsafeMutablePointer(_d.impl)!.pointee = newValue }
    }
}
