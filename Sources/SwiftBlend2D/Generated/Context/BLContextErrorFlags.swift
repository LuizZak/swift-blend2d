// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Error flags that are accumulated during the rendering context lifetime and that can be queried through
/// `BLContext::queryAccumulatedErrorFlags()`. The reason why these flags exist is that errors can happen during
/// asynchronous rendering, and there is no way the user can catch these errors.
extension BLContextErrorFlags: OptionSet { }

public extension BLContextErrorFlags {
    /// No flags.
    static let noFlags = BL_CONTEXT_ERROR_NO_FLAGS
    
    /// The rendering context returned or encountered `BLResultCode.errorInvalidValue`, which is mostly related to the function
    /// argument handling. It's very likely some argument was wrong when calling `BLContext` API.
    static let invalidValue = BL_CONTEXT_ERROR_FLAG_INVALID_VALUE
    
    /// Invalid state describes something wrong, for example a pipeline compilation error.
    static let invalidState = BL_CONTEXT_ERROR_FLAG_INVALID_STATE
    
    /// The rendering context has encountered invalid geometry.
    static let invalidGeometry = BL_CONTEXT_ERROR_FLAG_INVALID_GEOMETRY
    
    /// The rendering context has encountered invalid glyph.
    static let invalidGlyph = BL_CONTEXT_ERROR_FLAG_INVALID_GLYPH
    
    /// The rendering context has encountered invalid or uninitialized font.
    static let invalidFont = BL_CONTEXT_ERROR_FLAG_INVALID_FONT
    
    /// Thread pool was exhausted and couldn't acquire the requested number of threads.
    static let threadPoolExhausted = BL_CONTEXT_ERROR_FLAG_THREAD_POOL_EXHAUSTED
    
    /// Out of memory condition.
    static let outOfMemory = BL_CONTEXT_ERROR_FLAG_OUT_OF_MEMORY
    
    /// Unknown error, which we don't have flag for.
    static let unknownError = BL_CONTEXT_ERROR_FLAG_UNKNOWN_ERROR
}
