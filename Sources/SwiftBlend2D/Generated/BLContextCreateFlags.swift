// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Rendering context create-flags.
extension BLContextCreateFlags: OptionSet { }

public extension BLContextCreateFlags {
    /// No flags.
    static let noFlags = BL_CONTEXT_CREATE_NO_FLAGS
    
    /// Disables JIT pipeline generator.
    static let disableJit = BL_CONTEXT_CREATE_FLAG_DISABLE_JIT
    
    /// Fallbacks to a synchronous rendering in case that the rendering engine wasn't able to acquire threads. This
    /// flag only makes sense when the asynchronous mode was specified by having `threadCount` greater than 0. If the
    /// rendering context fails to acquire at least one thread it would fallback to synchronous mode with no worker
    /// threads.
    /// 
    /// \note If this flag is specified with `threadCount == 1` it means to immediately fallback to synchronous
    /// rendering. It's only practical to use this flag with 2 or more requested threads.
    static let fallbackToSync = BL_CONTEXT_CREATE_FLAG_FALLBACK_TO_SYNC
    
    /// If this flag is specified and asynchronous rendering is enabled then the context would create its own isolated
    /// thread-pool, which is useful for debugging purposes.
    /// 
    /// Do not use this flag in production as rendering contexts with isolated thread-pool have to create and destroy all
    /// threads they use. This flag is only useful for testing, debugging, and isolated benchmarking.
    static let isolatedThreadPool = BL_CONTEXT_CREATE_FLAG_ISOLATED_THREAD_POOL
    
    /// If this flag is specified and JIT pipeline generation enabled then the rendering context would create its own
    /// isolated JIT runtime. which is useful for debugging purposes. This flag will be ignored if JIT pipeline
    /// compilation is either not supported or was disabled by other flags.
    /// 
    /// Do not use this flag in production as rendering contexts with isolated JIT runtime do not use global pipeline
    /// cache, that's it, after the rendering context is destroyed the JIT runtime is destroyed with it with all
    /// compiled pipelines. This flag is only useful for testing, debugging, and isolated benchmarking.
    static let isolatedJitRuntime = BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_RUNTIME
    
    /// Enables logging to stderr of isolated runtime.
    /// 
    /// \note Must be used with \ref BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_RUNTIME otherwise it would have no effect.
    static let isolatedJitLogging = BL_CONTEXT_CREATE_FLAG_ISOLATED_JIT_LOGGING
    
    /// Override CPU features when creating isolated context.
    static let overrideCpuFeatures = BL_CONTEXT_CREATE_FLAG_OVERRIDE_CPU_FEATURES
}