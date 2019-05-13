import blend2d

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
    @inlinable
    func toBLContextCreateInfo() -> BLContextCreateInfo {
        return BLContextCreateInfo(flags: flags.rawValue,
                                   threadCount: UInt32(threadCount),
                                   cpuFeatures: cpuFeatures.rawValue,
                                   reserved: (0, 0, 0, 0, 0))
    }
}
