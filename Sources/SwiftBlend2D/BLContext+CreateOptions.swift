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
        
        public init(flags: BLContextCreateFlags = [],
                    cpuFeatures: BLRuntimeCpuFeatures = [],
                    threadCount: UInt32 = 0,
                    commandQueueLimit: UInt32 = 0) {
            
            self.flags = flags
            self.cpuFeatures = cpuFeatures
            self.threadCount = threadCount
            self.commandQueueLimit = commandQueueLimit
        }
    }
}

extension BLContext.CreateOptions {
    @inlinable
    func toBLContextCreateInfo() -> BLContextCreateInfo {
        return BLContextCreateInfo(flags: UInt32(flags.rawValue),
                                   threadCount: threadCount,
                                   cpuFeatures: UInt32(cpuFeatures.rawValue),
                                   commandQueueLimit: commandQueueLimit,
                                   reserved: (0, 0, 0, 0))
    }
}
