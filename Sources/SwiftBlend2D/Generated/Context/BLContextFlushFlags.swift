// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Rendering context flush-flags, use with `BLContext::flush()`.
extension BLContextFlushFlags: OptionSet { }

public extension BLContextFlushFlags {
    static let noFlags = BL_CONTEXT_FLUSH_NO_FLAGS
    
    /// Flush the command queue and wait for its completion (will block).
    static let sync = BL_CONTEXT_FLUSH_SYNC
}