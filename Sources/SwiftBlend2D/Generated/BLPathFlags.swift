// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Path flags.
extension BLPathFlags: OptionSet { }

public extension BLPathFlags {
    /// No flags.
    static let noFlags = BL_PATH_NO_FLAGS
    
    /// Path is empty (no commands or close commands only).
    static let empty = BL_PATH_FLAG_EMPTY
    
    /// Path contains multiple figures.
    static let multiple = BL_PATH_FLAG_MULTIPLE
    
    /// Path contains one or more quad curves.
    static let quads = BL_PATH_FLAG_QUADS
    
    /// Path contains one or more cubic curves.
    static let cubics = BL_PATH_FLAG_CUBICS
    
    /// Path is invalid.
    static let invalid = BL_PATH_FLAG_INVALID
    
    /// Flags are dirty (not reflecting the current status).
    static let dirty = BL_PATH_FLAG_DIRTY
}
