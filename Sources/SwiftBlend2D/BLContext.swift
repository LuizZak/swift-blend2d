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
    ///   - options: Options to use when creating the new context
    public init?(image: BLImage, options: CreateOptions? = nil) {
        if var options = options?.toBLContextCreateOptions() {
            super.init {
                try? handleErrorResults(
                    blContextInitAs($0, &image.object, &options)
                )
            }
        } else {
            super.init {
                try? handleErrorResults(
                    blContextInitAs($0, &image.object, nil)
                )
            }
        }
    }
    
    public func setCompOp(_ op: BLCompOp) {
        ensureNotEnded()
        
        blContextSetCompOp(&object, op.rawValue)
    }
    
    /// Fills everything.
    public func fillAll() {
        ensureNotEnded()
        
        blContextFillAll(&object)
    }
    
    public func setFillStyleRgba32(_ value: UInt32) {
        ensureNotEnded()
        
        blContextSetFillStyleRgba32(&self.object, value)
    }
    
    public func fillPath(_ path: BLPath) {
        ensureNotEnded()
        
        blContextFillPathD(&object, &path.object)
    }
    
    /// Waits for completion of all render commands and detaches the rendering
    /// context from the rendering target. After `end()` completes the rendering
    /// context implementation would be released and replaced by a built-in null
    /// instance (no context).
    ///
    /// - note: After a call to `end`, no more invocations should be performed
    /// on this context instance.
    public func end() {
        blContextEnd(&object)
        
        _ended = true
    }
    
    private func ensureNotEnded() {
        if _ended {
            fatalError("Cannot manipulate BLContext after it has ended via end()")
        }
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
