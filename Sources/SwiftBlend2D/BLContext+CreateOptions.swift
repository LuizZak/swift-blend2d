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
        public var threadCount: UInt32 = 0
        
        // TODO: To be documented, has no effect at the moment.
        /// Maximum number of commands to be queued.
        ///
        /// If this parameter is zero the queue size will be determined automatically.
        ///
        public var commandQueueLimit: UInt32
    }
}

public extension BLContext.CreateOptions {
    /// CPU features Blend2D supports.
    /// Only use when create flags contains `Flag.overrideFeatures`.
    struct CPUFeature: OptionSet {
        public static let empty: CPUFeature = []
        
        public static let x86_SSE2 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_sse2.rawValue)
        public static let x86_SSE3 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_sse3.rawValue)
        public static let x86_SSSE3 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_ssse3.rawValue)
        public static let x86_SSE4_1 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_sse4_1.rawValue)
        public static let x86_SSE4_2 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_sse4_2.rawValue)
        public static let x86_AVX = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_avx.rawValue)
        public static let x86_AVX2 = CPUFeature(rawValue: BLRuntimeCpuFeatures.x86_avx2.rawValue)
        
        public var rawValue: UInt32
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
    }
    
    /// Rendering context create-flags.
    struct Flag: OptionSet {
        public static let empty: Flag = []
        
        /// When creating an asynchronous rendering context that uses threads for
        /// rendering, the rendering context can sometimes allocate less threads
        /// than specified if the built-in thread-pool doesn't have enough threads
        /// available. This flag will force the thread-pool to override the thread
        /// limit temporarily to allocate at least one thread.
        ///
        /// - note: This flag is ignored if `BLContextCreateInfo::threadCount <= 1`.
        /// If it's specified with `BL_CONTEXT_CREATE_FLAG_FORCE_ALL_THREADS` then
        /// the latter has a precedence.
        public static let forceOneThread = Flag(rawValue: BLContextCreateFlags.forceOneThread.rawValue)

        /// When creating an asynchronous rendering context that uses threads for
        /// rendering, the rendering context can sometimes allocate less threads
        /// than specified if the built-in thread-pool doesn't have enough threads
        /// available. This flag will force the thread-pool to override the thread
        /// limit temporarily to fulfill the thread count requirement completely.
        ///
        /// - note: This flag is ignored if `BLContextCreateInfo::threadCount <= 1`.
        public static let forceAllThreads = Flag(rawValue: BLContextCreateFlags.forceAllThreads.rawValue)

        /// Fallbacks to a synchronous rendering in case that acquiring threads
        /// from the thread-pool failed. This flag only makes sense when the
        /// asynchronous mode was specified by having `threadCount` greater than 0.
        /// If the rendering context fails to acquire at least one thread it would
        /// fallback to synchronous mode instead of staying asynchronous with no
        /// worker threads, which is possible.
        ///
        /// - note: If this flag is specified with `threadCount == 1` it means to
        /// immedialy fallback to synchronous rendering. It's only practical to
        /// use this flag with 2 threads and higher.
        public static let fallbackToSync = Flag(rawValue: BLContextCreateFlags.fallbackToSync.rawValue)

        /// If this flag is specified and asynchronous rendering is enabled then
        /// the context would create its own isolated thread-pool, which is useful
        /// for debugging purposes.
        ///
        /// Do not use this flag in production as rendering contexts with isolated
        /// thread-pool have to create and destroy all threads they use. This flag
        /// is only useful for testing, debugging, and isolated benchmarking.
        public static let isolatedThreadPool = Flag(rawValue: BLContextCreateFlags.isolatedThreadPool.rawValue)

        /// If this flag is specified and JIT pipeline generation enabled then the
        /// rendering context would create its own isolated JIT runtime. which is
        /// useful for debugging purposes. This flag will be ignored if JIT pipeline
        /// generation is either not supported or was disabled by other flags.
        ///
        /// Do not use this flag in production as rendering contexts with isolated
        /// JIT runtime do not use global pipeline cache, that's it, after the
        /// rendering context is destroyed the JIT runtime is destroyed with it with
        /// all compiled pipelines. This flag is only useful for testing, debugging,
        /// and isolated benchmarking.
        public static let isolatedJit = Flag(rawValue: BLContextCreateFlags.isolatedJit.rawValue)

        /// Override CPU features when creating isolated context.
        public static let overrideCpuFeatures = Flag(rawValue: BLContextCreateFlags.overrideCpuFeatures.rawValue)
        
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
                                   threadCount: threadCount,
                                   cpuFeatures: cpuFeatures.rawValue,
                                   commandQueueLimit: commandQueueLimit,
                                   reserved: (0, 0, 0, 0))
    }
}
