import blend2d

public class BLContext: BLBaseClass<BLContextCore> {
    private var _ended: Bool = false
    
    public override init() {
        super.init()
    }
    
    /// Initializes a new context that draws on a given image.
    ///
    /// Returns nil, in case an invalid image state was provided.
    ///
    /// - Parameters:
    ///   - image: The image to draw on. If the image is empty (with default
    /// constructor BLImage.init()), the initialization fails.
    ///   - options: Options to use when creating the new context.
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
    public func begin(image: BLImage, options: CreateOptions? = nil) {
        let options = options?.toBLContextCreateInfo()
        
        withUnsafeNullablePointer(to: options) {
            blContextBegin(&object, &image.object, $0)
        }
    }
    
    /// Waits for completion of all render commands and detaches the rendering
    /// context from the rendering target. After `end()` completes the rendering
    /// context implementation would be released and replaced by a built-in null
    /// instance (no context).
    public func end() {
        blContextEnd(&object)
        
        _ended = true
    }
    
    public func userToMeta() {
        // TODO: Figure out what this does and doc comment this method.
        blContextUserToMeta(&object)
    }
    
    public func setRenderingQualityHint(_ value: BLRenderingQuality) {
        blContextSetHint(&object, BL_CONTEXT_HINT_RENDERING_QUALITY.rawValue, value.rawValue)
    }
    
    public func setGradientQualityHint(_ value: BLGradientQuality) {
        blContextSetHint(&object, BL_CONTEXT_HINT_GRADIENT_QUALITY.rawValue, value.rawValue)
    }
    
    public func setPatternQualityHint(_ value: BLPatternQuality) {
        blContextSetHint(&object, BL_CONTEXT_HINT_PATTERN_QUALITY.rawValue, value.rawValue)
    }
    
    public func setFlattenMode(_ value: BLFlattenMode) {
        blContextSetFlattenMode(&object, value.rawValue)
    }
    
    public func setFlattenTolerance(_ value: Double) {
        blContextSetFlattenTolerance(&object, value)
    }
    
    public func setApproximationOptions(_ value: BLApproximationOptions) {
        var value = value
        blContextSetApproximationOptions(&object, &value)
    }
    
    public func setCompOp(_ op: BLCompOp) {
        blContextSetCompOp(&object, op.rawValue)
    }
    
    public func setGlobalAlpha(_ value: Double) {
        blContextSetGlobalAlpha(&object, value)
    }
    
    public func setFillRule(_ value: BLFillRule) {
        blContextSetFillRule(&object, value.rawValue)
    }
    
    public func setFillAlpha(_ value: Double) {
        blContextSetFillAlpha(&object, value)
    }
    
    // TODO: Implement blContextGetFillStyle
    func getFillStyle() {
        
    }
    
    public func setFillStyle(_ gradient: BLGradient) {
        blContextSetFillStyle(&object, &gradient.object)
    }
    
    public func setFillStyle(_ pattern: BLPattern) {
        blContextSetFillStyle(&object, &pattern.object)
    }
    
    /// Returns the RGBA32 fill style for this context.
    /// Returns nil, in case the current fill style mode is not compatible with
    /// RGBA32.
    public func getFillStyleRgba32() -> UInt32? {
        var value: UInt32 = 0
        if blContextGetFillStyleRgba32(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func setFillStyleRgba32(_ value: UInt32) {
        blContextSetFillStyleRgba32(&object, value)
    }
    
    public func setFillStyle(_ value: BLRgba32) {
        blContextSetFillStyleRgba32(&object, value.value)
    }
    
    /// Returns the RGBA64 fill style for this context.
    /// Returns nil, in case the current fill style mode is not compatible with
    /// RGBA64.
    public func getFillStyleRgba64() -> UInt64? {
        var value: UInt64 = 0
        if blContextGetFillStyleRgba64(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func setFillStyleRgba64(_ value: UInt64) {
        blContextSetFillStyleRgba64(&object, value)
    }
    
    public func setFillStyle(_ value: BLRgba64) {
        blContextSetFillStyleRgba64(&object, value.value)
    }
    
    //! Sets stroke width to `width`.
    public func setStrokeWidth(_ width: Double) {
        blContextSetStrokeWidth(&object, width)
    }
    
    //! Sets miter limit to `miterLimit`.
    public func setStrokeMiterLimit(_ miterLimit: Double) {
        blContextSetStrokeMiterLimit(&object, miterLimit)
    }
    
    //! Sets stroke cap of the specified `type` to `strokeCap`.
    public func setStrokeCap(_ position: BLStrokeCapPosition, strokeCap: BLStrokeCap) {
        blContextSetStrokeCap(&object, position.rawValue, strokeCap.rawValue)
    }
    
    //! Sets all stroke caps to `strokeCap`.
    public func setStrokeCaps(_ strokeCap: BLStrokeCap) {
        blContextSetStrokeCaps(&object, strokeCap.rawValue)
    }
    
    /// Sets stroke start cap to `strokeCap`.
    public func setStrokeStartCap(_ strokeCap: BLStrokeCap) {
        setStrokeCap(.start, strokeCap: strokeCap)
    }
    /// Sets stroke end cap to `strokeCap`.
    public func setStrokeEndCap(_ strokeCap: BLStrokeCap) {
        setStrokeCap(.end, strokeCap: strokeCap)
    }
    
    public func setStrokeJoin(_ strokeJoin: BLStrokeJoin) {
        blContextSetStrokeJoin(&object, strokeJoin.rawValue)
    }
    
    /// Sets stroke dash-offset to `dashOffset`.
    public func setStrokeDashOffset(_ dashOffset: Double) {
        blContextSetStrokeDashOffset(&object, dashOffset)
    }
    
    /// Sets stroke dash-array to `dashArray`.
    public func setStrokeDashArray(_ dashArray: [Double]) {
        let array = BLArray(array: dashArray)
        blContextSetStrokeDashArray(&object, &array.object)
    }
    
    /// Sets stroke transformation order to `transformOrder`.
    public func setStrokeTransformOrder(_ transformOrder: BLStrokeTransformOrder) {
        blContextSetStrokeTransformOrder(&object, transformOrder.rawValue)
    }
    
    /// Sets all stroke `options`.
    public func setStrokeOptions(_ options: BLStrokeOptionsCore) {
        var options = options
        blContextSetStrokeOptions(&object, &options)
    }
    
    public func setStrokeAlpha(_ alpha: Double) {
        blContextSetStrokeAlpha(&object, alpha)
    }
    
    // TODO: Implement getStrokeStyle
    func getStrokeStyle() /* -> ... */ {
        // blContextGetStrokeStyle(&object, ...)
    }
    
    public func getStrokeStyleRgba32() -> UInt32? {
        var value: UInt32 = 0
        if blContextGetStrokeStyleRgba32(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func getStrokeStyleRgba64() -> UInt64? {
        var value: UInt64 = 0
        if blContextGetStrokeStyleRgba64(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func setStrokeStyle(_ gradient: BLGradient) {
         blContextSetStrokeStyle(&object, &gradient.object)
    }
    
    public func setStrokeStyle(_ pattern: BLPattern) {
        blContextSetStrokeStyle(&object, &pattern.object)
    }
    
    public func setStrokeStyleRgba32(_ rgba32: UInt32) {
        blContextSetStrokeStyleRgba32(&object, rgba32)
    }
    
    public func setStrokeStyleRgba64(_ rgba64: UInt64) {
        blContextSetStrokeStyleRgba64(&object, rgba64)
    }
    
    public func clipToRect(_ rect: BLRectI) {
        var rect = rect
        
        blContextClipToRectI(&object, &rect)
    }
    
    public func clipToRect(_ rect: BLRect) {
        var rect = rect
        
        blContextClipToRectD(&object, &rect)
    }
    
    public func restoreClipping() {
        blContextRestoreClipping(&object)
    }
    
    public func clearAll() {
        blContextClearAll(&object)
    }
    
    public func clearRect(_ rect: BLRectI) {
        var rect = rect
        
        blContextClearRectI(&object, &rect)
    }
    
    public func clearRect(_ rect: BLRect) {
        var rect = rect
        
        blContextClearRectD(&object, &rect)
    }
    
    /// Fills everything.
    public func fillAll() {
        blContextFillAll(&object)
    }
    
    @inlinable
    public func fillRect(x: Int, y: Int, width: Int, height: Int) {
        fillRect(BLRectI(x: Int32(x), y: Int32(y), w: Int32(width), h: Int32(height)))
    }
    
    @inlinable
    public func fillRect(x: Double, y: Double, width: Double, height: Double) {
        fillRect(BLRect(x: x, y: y, w: width, h: height))
    }
    
    @inlinable
    public func fillRect(_ rect: BLRectI) {
        var rect = rect
        
        blContextFillRectI(&object, &rect)
    }
    
    @inlinable
    public func fillRect(_ rect: BLRect) {
        var rect = rect
        
        blContextFillRectD(&object, &rect)
    }
    
    @inlinable
    public func fillRoundRect(x: Double, y: Double, width: Double, height: Double, rx: Double, ry: Double) {
        fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: rx, ry: ry))
    }
    
    @inlinable
    public func fillRoundRect(x: Double, y: Double, width: Double, height: Double, radius: Double) {
        fillRoundRect(BLRoundRect(x: x, y: y, w: width, h: height, rx: radius, ry: radius))
    }
    
    @inlinable
    public func fillRoundRect(_ rect: BLRoundRect) {
        fillGeometry(rect)
    }
    
    @inlinable
    public func fillCircle(x: Double, y: Double, radius: Double) {
        fillCircle(BLCircle(cx: x, cy: y, r: radius))
    }
    
    @inlinable
    public func fillCircle(_ circle: BLCircle) {
        fillGeometry(circle)
    }
    
    public func fillPath(_ path: BLPathCore) {
        var path = path
        
        blContextFillPathD(&object, &path)
    }
    
    @inlinable
    public func fillGeometry(_ roundRect: BLRoundRect) {
        var roundRect = roundRect
        blContextFillGeometry(&object, BLGeometryType.roundRect.rawValue, &roundRect)
    }
    
    @inlinable
    public func fillGeometry(_ circle: BLCircle) {
        var circle = circle
        blContextFillGeometry(&object, BLGeometryType.circle.rawValue, &circle)
    }
    
    public func fillText<S: StringProtocol>(_ text: S, at point: BLPointI, font: BLFont) {
        var point = point
        text.withCString { pointer -> Void in
            blContextFillTextI(&object, &point, &font.object, pointer, text.utf8.count, BLTextEncoding.utf8.rawValue)
        }
    }
    
    public func fillText<S: StringProtocol>(_ text: S, at point: BLPoint, font: BLFont) {
        var point = point
        text.withCString { pointer -> Void in
            blContextFillTextD(&object, &point, &font.object, pointer, text.utf8.count, BLTextEncoding.utf8.rawValue)
        }
    }
    
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFont) {
        var point = point
        var glyphRun = glyphRun
        
        blContextFillGlyphRunI(&object, &point, &font.object, &glyphRun)
    }
    
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFont) {
        var point = point
        var glyphRun = glyphRun
        
        blContextFillGlyphRunD(&object, &point, &font.object, &glyphRun)
    }
    
    public func strokeRectangle(_ rect: BLRectI) {
        var rect = rect
        
        blContextStrokeRectI(&object, &rect)
    }
    
    public func strokeRectangle(_ rect: BLRect) {
        var rect = rect
        
        blContextStrokeRectD(&object, &rect)
    }
    
    public func strokePath(_ path: BLPath) {
        blContextStrokePathD(&object, &path.object)
    }
    
    // TODO: Implement proper strokeGeometry overload
    func strokeGeometry(_ geometryType: BLGeometryType, geometryData: UnsafeRawPointer /* geometryData: ... */) {
        blContextStrokeGeometry(&object, geometryType.rawValue, geometryData)
    }
    
    public func strokeText(_ text: String, at point: BLPointI, font: BLFontCore) {
        var cString = text.utf8CString
        var point = point
        var font = font
        
        blContextStrokeTextI(&object, &point, &font, &cString, cString.count - 1, BLTextEncoding.utf8.rawValue)
    }
    
    public func strokeText(_ text: String, at point: BLPoint, font: BLFont) {
        var cString = text.utf8CString
        var point = point
        
        blContextStrokeTextD(&object, &point, &font.object, &cString, cString.count - 1, BLTextEncoding.utf8.rawValue)
    }
    
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFont) {
        var glyphRun = glyphRun
        var point = point
        
        blContextStrokeGlyphRunI(&object, &point, &font.object, &glyphRun)
    }
    
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFont) {
        var glyphRun = glyphRun
        var point = point
        
        blContextStrokeGlyphRunD(&object, &point, &font.object, &glyphRun)
    }
    
    public func blitImage(_ image: BLImage, at point: BLPointI, imageArea: BLRectI? = nil) {
        var point = point
        
        withUnsafeNullablePointer(to: imageArea) {
            blContextBlitImageI(&object, &point, &image.object, $0)
        }
    }
    
    public func blitImage(_ image: BLImage, at point: BLPoint, imageArea: BLRectI? = nil) {
        var point = point
        
        withUnsafeNullablePointer(to: imageArea) {
            blContextBlitImageD(&object, &point, &image.object, $0)
        }
    }
    
    public func blitScaledImage(_ image: BLImage, rectangle: BLRectI, imageArea: BLRectI? = nil) {
        var rectangle = rectangle
        
        withUnsafeNullablePointer(to: imageArea) {
            blContextBlitScaledImageI(&object, &rectangle, &image.object, $0)
        }
    }
    
    public func blitScaledImage(_ image: BLImage, rectangle: BLRect, imageArea: BLRectI? = nil) {
        var rectangle = rectangle
        
        withUnsafeNullablePointer(to: imageArea) {
            blContextBlitScaledImageD(&object, &rectangle, &image.object, $0)
        }
    }
    
    public func fillPath(_ path: BLPath) {
        blContextFillPathD(&object, &path.object)
    }
    
    public func flush(flags: BLContextFlushFlags) {
        blContextFlush(&object, flags.rawValue)
    }
}

// MARK: - State saving/restoration
public extension BLContext {
    /// Saves the current rendering context state.
    ///
    /// Blend2D uses optimizations that make `save()` a cheap operation. Only
    /// core values are actually saved in `save()`, others will only be saved if
    /// they are modified. This means that consecutive calls to `save()` and
    /// `restore()` do almost nothing.
    @discardableResult
    func save() -> BLContextCookie {
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
    //      state.
    func restore(from cookie: BLContextCookie) -> BLResult {
        var cookie = cookie
        return blContextRestore(&object, &cookie)
    }
}

public extension BLContext {
    @discardableResult
    func resetMatrix() -> BLResult {
        return object.impl.pointee.virt.pointee.matrixOp(object.impl, BLMatrix2DOp.reset.rawValue, nil)
    }
    @discardableResult
    func translate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.translate, x, y)
    }
    @discardableResult
    func translate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.translate, p.x, p.y)
    }
    @discardableResult
    func translate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.translate, p)
    }
    @discardableResult
    func scale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.scale, xy, xy)
    }
    @discardableResult
    func scale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.scale, x, y)
    }
    @discardableResult
    func scale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.scale, p.x, p.y)
    }
    @discardableResult
    func scale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.scale, p)
    }
    @discardableResult
    func skew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.skew, x, y)
    }
    @discardableResult
    func skew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.skew, p)
    }
    @discardableResult
    func rotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.rotate, angle)
    }
    @discardableResult
    func rotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, x, y)
    }
    @discardableResult
    func rotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, point.x, point.y)
    }
    @discardableResult
    func rotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.rotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    func transform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.transform, matrix)
    }
    @discardableResult
    func postTranslate(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postTranslate, x, y)
    }
    @discardableResult
    func postTranslate(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postTranslate, p.x, p.y)
    }
    @discardableResult
    func postTranslate(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postTranslate, p)
    }
    @discardableResult
    func postScale(xy: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, xy, xy)
    }
    @discardableResult
    func postScale(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postScale, x, y)
    }
    @discardableResult
    func postScale(by p: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postScale, p.x, p.y)
    }
    @discardableResult
    func postScale(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postScale, p)
    }
    @discardableResult
    func postSkew(x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postSkew, x, y)
    }
    @discardableResult
    func postSkew(by p: BLPoint) -> BLResult {
        return _applyMatrixOp(.postSkew, p)
    }
    @discardableResult
    func postRotate(angle: Double) -> BLResult {
        return _applyMatrixOp(.postRotate, angle)
    }
    @discardableResult
    func postRotate(angle: Double, x: Double, y: Double) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, x, y)
    }
    @discardableResult
    func postRotate(angle: Double, point: BLPoint) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, point.x, point.y)
    }
    @discardableResult
    func postRotate(angle: Double, point: BLPointI) -> BLResult {
        return _applyMatrixOpV(.postRotatePt, angle, Double(point.x), Double(point.y))
    }
    @discardableResult
    func postTransform(_ matrix: BLMatrix2D) -> BLResult {
        return _applyMatrixOp(.postTransform, matrix)
    }
}

internal extension BLContext {
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLMatrix2D) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            return object.impl.pointee.virt.pointee.matrixOp(object.impl, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: BLPoint) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            return object.impl.pointee.virt.pointee.matrixOp(object.impl, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOp(_ opType: BLMatrix2DOp, _ opData: Double) -> BLResult {
        return withUnsafePointer(to: opData) { pointer in
            return object.impl.pointee.virt.pointee.matrixOp(object.impl, opType.rawValue, pointer)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV(_ opType: BLMatrix2DOp, _ args: Double...) -> BLResult {
        return args.withUnsafeBytes { pointer in
            return object.impl.pointee.virt.pointee.matrixOp(object.impl, opType.rawValue, pointer.baseAddress)
        }
    }
    
    /// Applies a matrix operation to the current transformation matrix (internal).
    func _applyMatrixOpV<T: BinaryInteger>(_ opType: BLMatrix2DOp, _ args: T...) -> BLResult {
        return args.map { Double($0) }.withUnsafeBytes { pointer in
            return object.impl.pointee.virt.pointee.matrixOp(object.impl, opType.rawValue, pointer.baseAddress)
        }
    }
}
extension BLContextCore: CoreStructure {
    public static let initializer = blContextInit
    public static let deinitializer = blContextReset
    public static var assignWeak = blContextAssignWeak
}
