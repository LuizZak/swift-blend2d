// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// File read flags used by `BLFileSystem::readFile()`.
extension BLFileReadFlags: OptionSet { }

public extension BLFileReadFlags {
    /// No flags.
    static let noFlags = BL_FILE_READ_NO_FLAGS
    
    /// Use memory mapping to read the content of the file.
    /// 
    /// The destination buffer `BLArray<>` would be configured to use the memory mapped buffer instead of allocating its
    /// own.
    static let mmapEnabled = BL_FILE_READ_MMAP_ENABLED
    
    /// Avoid memory mapping of small files.
    /// 
    /// The size of small file is determined by Blend2D, however, you should expect it to be 16kB or 64kB depending on
    /// host operating system.
    static let mmapAvoidSmall = BL_FILE_READ_MMAP_AVOID_SMALL
    
    /// Do not fallback to regular read if memory mapping fails. It's worth noting that memory mapping would fail for
    /// files stored on filesystem that is not local (like a mounted network filesystem, etc...).
    static let mmapNoFallback = BL_FILE_READ_MMAP_NO_FALLBACK
}
