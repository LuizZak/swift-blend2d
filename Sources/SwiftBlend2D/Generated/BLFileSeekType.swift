// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// File seek mode, see `BLFile::seek()`.
/// 
/// \note Seek constants should be compatible with constants used by both POSIX
/// and Windows API.
public extension BLFileSeekType {
    /// Seek from the beginning of the file (SEEK_SET).
    static let `set` = BL_FILE_SEEK_SET
    
    /// Seek from the current position (SEEK_CUR).
    static let cur = BL_FILE_SEEK_CUR
    
    /// Seek from the end of the file (SEEK_END).
    static let end = BL_FILE_SEEK_END
    
    /// Maximum value of `BLFileSeekType`.
    static let maxValue = BL_FILE_SEEK_MAX_VALUE
}
