import blend2d

public extension BLContext {
    struct CreateOptions {
        public var flags: BLContextCreateFlags
        
        // CPU features to use in isolated JIT runtime (if supported), only used
        // when `flags` contains `.overrideCpuFeatures`.
        public var cpuFeatures: BLRuntimeCpuFeatures
        
        /// Number of threads to acquire from thread-pool and use for rendering.
        ///
        /// If `threadCount` is zero it means to initialize the context for
        /// synchronous rendering. This means that every operation will take
        /// effect immediately.
        /// If the number is `1` or greater it means to initialize the context
        /// for asynchronous rendering - in this case `threadCount` specifies
        /// how many threads can execute in parallel.
        public var threadCount: UInt32
        
        // TODO: To be documented, has no effect at the moment.
        /// Maximum number of commands to be queued.
        ///
        /// If this parameter is zero the queue size will be determined automatically.
        ///
        public var commandQueueLimit: UInt32

        /// Maximum number of saved states.
        ///
        /// - note: Zero value tells the rendering engine to use the default saved
        /// state limit, which currently defaults to 4096 states. This option
        /// allows to even increase or decrease the limit, depending on the use
        /// case.
        public var savedStateLimit: UInt32

        /// Pixel origin.
        ///
        /// Pixel origin is an offset in pixel units that can be used as an origin
        /// for fetchers and effects that use a pixel X/Y coordinate in the
        /// calculation. One example of using pixel origin is dithering, where
        /// it's used to shift the dithering matrix.
        public var pixelOrigin: BLPointI
        
        public init(
            flags: BLContextCreateFlags = [],
            cpuFeatures: BLRuntimeCpuFeatures = [],
            threadCount: UInt32 = 0,
            commandQueueLimit: UInt32 = 0,
            savedStateLimit: UInt32 = 0,
            pixelOrigin: BLPointI = .zero
        ) {
            
            self.flags = flags
            self.cpuFeatures = cpuFeatures
            self.threadCount = threadCount
            self.commandQueueLimit = commandQueueLimit
            self.savedStateLimit = savedStateLimit
            self.pixelOrigin = pixelOrigin
        }
    }
}

extension BLContext.CreateOptions {
    @inlinable
    func toBLContextCreateInfo() -> BLContextCreateInfo {
        return BLContextCreateInfo(
            flags: UInt32(flags.rawValue),
            threadCount: threadCount,
            cpuFeatures: UInt32(cpuFeatures.rawValue),
            commandQueueLimit: commandQueueLimit,
            savedStateLimit: savedStateLimit,
            pixelOrigin: pixelOrigin,
            reserved: 0
        )
    }
}
