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
    
    // TODO: Implement blContextSetFillStyle
    func setFillStyle(/* ... */) {
        
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
    
    public func setStrokeWidth(_ width: Double) {
        blContextSetStrokeWidth(&object, width)
    }
    
    public func setStrokeMiterLimit(_ miterLimit: Double) {
        blContextSetStrokeMiterLimit(&object, miterLimit)
    }
    
    public func setStrokeCap(_ position: UInt32, strokeCap: UInt32) {
        blContextSetStrokeCap(&object, position, strokeCap)
    }
    
    public func setStrokeCaps(_ strokeCap: UInt32) {
        blContextSetStrokeCaps(&object, strokeCap)
    }
    
    public func setStrokeJoin(_ strokeJoin: UInt32) {
        blContextSetStrokeJoin(&object, strokeJoin)
    }
    
    public func setStrokeDashOffset(_ dashOffset: Double) {
        blContextSetStrokeDashOffset(&object, dashOffset)
    }
    
    public func setStrokeDashArray(_ dashArray: [Double]) {
        let array = BLArray(array: dashArray)
        blContextSetStrokeDashArray(&object, &array.object)
    }
    
    public func setStrokeTransformOrder(_ transformOrder: UInt32) {
        blContextSetStrokeTransformOrder(&object, transformOrder)
    }
    
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
    
    // TODO: Implement blContextSetStrokeStyle
    func setStrokeStyle(/* ... */) {
        // blContextSetStrokeStyle(&object, ...)
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
    
    public func fillRect(_ rect: BLRectI) {
        var rect = rect
        
        blContextFillRectI(&object, &rect)
    }
    
    public func fillRect(_ rect: BLRect) {
        var rect = rect
        
        blContextFillRectD(&object, &rect)
    }
    
    public func fillPath(_ path: BLPathCore) {
        var path = path
        
        blContextFillPathD(&object, &path)
    }
    
    // TODO: Implement blContextFillGeometry
    func fillGeometry(/* */) {
        
    }
    
    public func fillText(_ text: String, at point: BLPointI, font: BLFontCore) {
        var cString = text.utf8CString
        var point = point
        var font = font
        
        blContextFillTextI(&object, &point, &font, &cString, cString.count - 1, BLTextEncoding.utf8.rawValue)
    }
    
    public func fillText(_ text: String, at point: BLPoint, font: BLFontCore) {
        var cString = text.utf8CString
        var point = point
        var font = font
        
        blContextFillTextD(&object, &point, &font, &cString, cString.count - 1, BLTextEncoding.utf8.rawValue)
    }
    
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFontCore) {
        var point = point
        var font = font
        var glyphRun = glyphRun
        
        blContextFillGlyphRunI(&object, &point, &font, &glyphRun)
    }
    
    public func fillGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFontCore) {
        var point = point
        var font = font
        var glyphRun = glyphRun
        
        blContextFillGlyphRunD(&object, &point, &font, &glyphRun)
    }
    
    public func strokeRectangle(_ rect: BLRectI) {
        var rect = rect
        
        blContextStrokeRectI(&object, &rect)
    }
    
    public func strokeRectangle(_ rect: BLRect) {
        var rect = rect
        
        blContextStrokeRectD(&object, &rect)
    }
    
    public func strokePath(_ path: BLPathCore) {
        var path = path
        
        blContextStrokePathD(&object, &path)
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
    
    public func strokeText(_ text: String, at point: BLPoint, font: BLFontCore) {
        var cString = text.utf8CString
        var point = point
        var font = font
        
        blContextStrokeTextD(&object, &point, &font, &cString, cString.count - 1, BLTextEncoding.utf8.rawValue)
    }
    
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPointI, font: BLFontCore) {
        var glyphRun = glyphRun
        var point = point
        var font = font
        
        blContextStrokeGlyphRunI(&object, &point, &font, &glyphRun)
    }
    
    public func strokeGlyphRun(_ glyphRun: BLGlyphRun, at point: BLPoint, font: BLFontCore) {
        var glyphRun = glyphRun
        var point = point
        var font = font
        
        blContextStrokeGlyphRunD(&object, &point, &font, &glyphRun)
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

extension BLContextCore: CoreStructure {
    public static let initializer = blContextInit
    public static let deinitializer = blContextReset
}

public extension BLContext {
    struct CreateOptions {
        public var flags: Flag = .empty
        
        // CPU features to use in isolated JIT runtime (if supported), only used
        // when `flags` contains `.overrideCpuFeatures`.
        public var cpuFeatures: CPUFeature = .empty
        
        /// Number of threads to acquire from thread-pool and use for rendering.
        ///
        /// If `threadCount` is zero it means to initialize the context for
        /// synchronous rendering. This means that every operation will take
        /// effect immediately.
        /// If the number is `1` or greater it means to initialize the context
        /// for asynchronous rendering - in this case `threadCount` specifies
        /// how many threads can execute in parallel.
        public var threadCount: Int = 0
    }
}

public extension BLContext.CreateOptions {
    /// CPU features Blend2D supports.
    /// Only use when create flags contains `Flag.overrideFeatures`.
    struct CPUFeature: OptionSet {
        public static let empty: CPUFeature = []
        
        public static let x86_SSE2 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSE2.rawValue)
        public static let x86_SSE3 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSE3.rawValue)
        public static let x86_SSSE3 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSSE3.rawValue)
        public static let x86_SSE4_1 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSE4_1.rawValue)
        public static let x86_SSE4_2 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSE4_2.rawValue)
        public static let x86_AVX = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_AVX.rawValue)
        public static let x86_AVX2 = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_AVX2.rawValue)
        
        public var rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    
    /// Rendering context create-flags.
    struct Flag: OptionSet {
        public static let empty: Flag = []
        
        /// When creating an asynchronous rendering context that uses threads
        /// for rendering, the rendering context can sometimes allocate less
        /// threads than specified if the built-in thread-pool doesn't have
        /// enough threads available. This flag will force the thread-pool to
        /// override the thread limit temporarily to fulfill the thread count
        /// requirement.
        ///
        /// NOTE: This flag is ignored if `BLContext.CreateOptions.threadCount == 0`.
        public static let forceThreads = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_FORCE_THREADS.rawValue)
        
        /// Fallback to synchronous rendering in case that acquiring threads
        /// from thread-pool failed. This flag only makes sense when asynchronous
        /// mode was specified by having non-zero thread count. In that case if
        /// the
        /// rendering context fails to acquire at least one thread it would
        /// fallback to synchronous mode instead.
        ///
        /// NOTE: This flag is ignored if `BLContext.CreateOptions.threadCount == 0`.
        public static let fallbackToSync = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_FALLBACK_TO_SYNC.rawValue)
        
        /// If this flag is specified and asynchronous rendering is enabled then
        /// the context would create its own isolated thread-pool, which is
        /// useful for debugging purposes.
        ///
        /// Do not use this flag in production as rendering contexts with
        /// isolated thread-pool have to create and destroy all threads they use.
        /// This flag is only useful for testing, debugging, and isolated
        /// benchmarking.
        public static let isolatedThreads = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_ISOLATED_THREADS.rawValue)
        
        /// If this flag is specified and JIT pipeline generation enabled then
        /// the rendering context would create its own isolated JIT runtime.
        /// which is useful for debugging purposes. This flag will be ignored if
        /// JIT pipeline generation is either not supported or was disabled by
        /// other flags.
        ///
        /// Do not use this flag in production as rendering contexts with isolated
        /// JIT runtime do not use global pipeline cache, that's it, after the
        /// rendering context is destroyed the JIT runtime is destroyed with it
        /// with all compiled pipelines. This flag is only useful for testing,
        /// debugging, and isolated benchmarking.
        public static let isolatedJit = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT.rawValue)
        
        /// Override CPU features when creating isolated context.
        public static let overrideCpuFeatures = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES.rawValue)
        
        public var rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

extension BLContext.CreateOptions {
    func toBLContextCreateInfo() -> BLContextCreateInfo {
        return BLContextCreateInfo(flags: flags.rawValue,
                                   threadCount: UInt32(threadCount),
                                   cpuFeatures: cpuFeatures.rawValue,
                                   reserved: (0, 0, 0, 0, 0))
    }
}
