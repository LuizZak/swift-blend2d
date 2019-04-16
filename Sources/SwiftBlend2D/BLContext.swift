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
        if var options = options?.toBLContextCreateOptions() {
            super.init {
                try? resultToError(
                    blContextInitAs($0, &image.object, &options)
                )
            }
        } else {
            super.init {
                try? resultToError(
                    blContextInitAs($0, &image.object, nil)
                )
            }
        }
    }
    
    public func userToMeta() {
        ensureNotEnded()
        
        // TODO: Figure out what this does and doc comment this method.
        blContextUserToMeta(&object)
    }
    
    public func setRenderingQualityHint(_ value: BLRenderingQuality) {
        ensureNotEnded()
        
        blContextSetHint(&object, BL_CONTEXT_HINT_RENDERING_QUALITY.rawValue, value.rawValue)
    }
    
    public func setGradientQualityHint(_ value: BLGradientQuality) {
        ensureNotEnded()
        
        blContextSetHint(&object, BL_CONTEXT_HINT_GRADIENT_QUALITY.rawValue, value.rawValue)
    }
    
    public func setPatternQualityHint(_ value: BLPatternQuality) {
        ensureNotEnded()
        
        blContextSetHint(&object, BL_CONTEXT_HINT_PATTERN_QUALITY.rawValue, value.rawValue)
    }
    
    public func setFlattenMode(_ value: BLFlattenMode) {
        ensureNotEnded()
        
        blContextSetFlattenMode(&object, value.rawValue)
    }
    
    public func setFlattenTolerance(_ value: Double) {
        ensureNotEnded()
        
        blContextSetFlattenTolerance(&object, value)
    }
    
    public func setApproximationOptions(_ value: BLApproximationOptions) {
        ensureNotEnded()
        
        var value = value
        blContextSetApproximationOptions(&object, &value)
    }
    
    public func setCompOp(_ op: BLCompOp) {
        ensureNotEnded()
        
        blContextSetCompOp(&object, op.rawValue)
    }
    
    public func setGlobalAlpha(_ value: Double) {
        ensureNotEnded()
        
        blContextSetGlobalAlpha(&object, value)
    }
    
    public func setFillRule(_ value: BLFillRule) {
        ensureNotEnded()
        
        blContextSetFillRule(&object, value.rawValue)
    }
    
    public func setFillAlpha(_ value: Double) {
        ensureNotEnded()
        
        blContextSetFillAlpha(&object, value)
    }
    
    // TODO: Implement blContextGetFillStyle
    func getFillStyle() {
        ensureNotEnded()
    }
    
    // TODO: Implement blContextSetFillStyle
    func setFillStyle(/* ... */) {
        ensureNotEnded()
    }
    
    /// Returns the RGBA32 fill style for this context.
    /// Returns nil, in case the current fill style mode is not compatible with
    /// RGBA32.
    public func getFillStyleRgba32() -> UInt32? {
        ensureNotEnded()
        
        var value: UInt32 = 0
        if blContextGetFillStyleRgba32(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func setFillStyleRgba32(_ value: UInt32) {
        ensureNotEnded()
        
        blContextSetFillStyleRgba32(&object, value)
    }
    
    /// Returns the RGBA64 fill style for this context.
    /// Returns nil, in case the current fill style mode is not compatible with
    /// RGBA64.
    public func getFillStyleRgba64() -> UInt64? {
        ensureNotEnded()
        
        var value: UInt64 = 0
        if blContextGetFillStyleRgba64(&object, &value) != BL_SUCCESS.rawValue {
            return nil
        }
        return value
    }
    
    public func setFillStyleRgba64(_ value: UInt64) {
        ensureNotEnded()
        
        blContextSetFillStyleRgba64(&object, value)
    }
    
    /// Fills everything.
    public func fillAll() {
        ensureNotEnded()
        
        blContextFillAll(&object)
    }
    
    public func fillPath(_ path: BLPath) {
        ensureNotEnded()
        
        blContextFillPathD(&object, &path.object)
    }
    
    public func flush(flags: BLContextFlushFlags) {
        ensureNotEnded()
        
        blContextFlush(&object, flags.rawValue)
    }
    
    /// Waits for completion of all render commands and detaches the rendering
    /// context from the rendering target. After `end()` completes the rendering
    /// context implementation would be released and replaced by a built-in null
    /// instance (no context).
    ///
    /// - note: After a call to `end`, no more invocations should be performed
    /// on this context instance.
    public func end() {
        ensureNotEnded()
        
        blContextEnd(&object)
        
        _ended = true
    }
    
    private func ensureNotEnded() {
        if _ended {
            fatalError("Cannot manipulate BLContext after it has ended via end()")
        }
    }
}

// MARK: - State saving/restoration
public extension BLContext {
    func save() -> BLContextCookie {
        ensureNotEnded()
        
        var cookie = BLContextCookie()
        blContextSave(&object, &cookie)
        return cookie
    }
    
    func restore(from cookie: BLContextCookie) -> BLResult {
        ensureNotEnded()
        
        var cookie = cookie
        return blContextRestore(&object, &cookie)
    }
}

extension BLContextCore: CoreStructure {
    public static var initializer = blContextInit
    public static var deinitializer = blContextReset
}

public extension BLContext {
    struct CreateOptions {
        public var flags: Flag = .empty
        public var cpuFeatures: CPUFeature = .empty
    }
}

public extension BLContext.CreateOptions {
    /// CPU features Blend2D supports.
    /// Only use when create flags contains `Flag.overrideFeatures`.
    struct CPUFeature: OptionSet {
        public static let empty: CPUFeature = []
        
        public static let x86_SSE = CPUFeature(rawValue: BL_RUNTIME_CPU_FEATURE_X86_SSE.rawValue)
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
        
        /// Create isolated context with own JIT runtime (testing).
        public static let isolatedRuntime = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_ISOLATED_RUNTIME.rawValue)
        /// Override CPU features when creating isolated context.
        public static let overrideFeatures = Flag(rawValue: BL_CONTEXT_CREATE_FLAG_OVERRIDE_FEATURES.rawValue)
        
        public var rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
}

extension BLContext.CreateOptions {
    func toBLContextCreateOptions() -> BLContextCreateOptions {
        return BLContextCreateOptions(flags: flags.rawValue, cpuFeatures: cpuFeatures.rawValue)
    }
}
