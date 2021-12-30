// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// Data access flags.
extension BLDataAccessFlags: OptionSet { }

public extension BLDataAccessFlags {
    /// No data access flags.
    static let noFlags = BL_DATA_ACCESS_NO_FLAGS
    
    /// Read access.
    static let read = BL_DATA_ACCESS_READ
    
    /// Write access.
    static let write = BL_DATA_ACCESS_WRITE
    
    /// Read and write access.
    static let rw = BL_DATA_ACCESS_RW
}
