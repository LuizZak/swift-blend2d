// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Blend2D runtime limits.
/// 
/// - note: These constanst are used across Blend2D, but they are not designed to be ABI stable. New versions of Blend2D
/// can increase certain limits without notice. Use runtime to query the limits dynamically, see `BLRuntimeBuildInfo`.
public extension BLRuntimeLimits {
    /// Maximum width and height of an image.
    static let maxImageSize = BL_RUNTIME_MAX_IMAGE_SIZE
    
    /// Maximum number of threads for asynchronous operations (including rendering).
    static let maxThreadCount = BL_RUNTIME_MAX_THREAD_COUNT
}
