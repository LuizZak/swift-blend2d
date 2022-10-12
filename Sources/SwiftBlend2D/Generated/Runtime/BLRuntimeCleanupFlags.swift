// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Runtime cleanup flags that can be used through `BLRuntime::cleanup()`.
extension BLRuntimeCleanupFlags: OptionSet { }

public extension BLRuntimeCleanupFlags {
    /// No flags.
    static let noFlags = BL_RUNTIME_CLEANUP_NO_FLAGS
    
    /// Cleanup object memory pool.
    static let objectPool = BL_RUNTIME_CLEANUP_OBJECT_POOL
    
    /// Cleanup zeroed memory pool.
    static let zeroedPool = BL_RUNTIME_CLEANUP_ZEROED_POOL
    
    /// Cleanup thread pool (would join unused threads).
    static let threadPool = BL_RUNTIME_CLEANUP_THREAD_POOL
    
    /// Cleanup everything.
    static let everything = BL_RUNTIME_CLEANUP_EVERYTHING
}