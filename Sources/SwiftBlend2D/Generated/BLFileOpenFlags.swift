// HEADS UP!: Auto-generated file, changes made directly here will be overwritten by code generators.

import blend2d

/// File open flags, see `BLFile::open()`.
extension BLFileOpenFlags: OptionSet { }

public extension BLFileOpenFlags {
    /// No flags.
    static let noFlags = BL_FILE_OPEN_NO_FLAGS
    
    /// Opens the file for reading.
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_RDONLY` (Posix)
    /// * `GENERIC_READ` (Windows)
    static let read = BL_FILE_OPEN_READ
    
    /// Opens the file for writing:
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_WRONLY` (Posix)
    /// * `GENERIC_WRITE` (Windows)
    static let write = BL_FILE_OPEN_WRITE
    
    /// Opens the file for reading & writing.
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_RDWR` (Posix)
    /// * `GENERIC_READ | GENERIC_WRITE` (Windows)
    static let rw = BL_FILE_OPEN_RW
    
    /// Creates the file if it doesn't exist or opens it if it does.
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_CREAT` (Posix)
    /// * `CREATE_ALWAYS` or `OPEN_ALWAYS` depending on other flags (Windows)
    static let create = BL_FILE_OPEN_CREATE
    
    /// Opens the file for deleting or renaming (Windows).
    /// 
    /// Adds `DELETE` flag when opening the file to `ACCESS_MASK`.
    static let delete = BL_FILE_OPEN_DELETE
    
    /// Truncates the file.
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_TRUNC` (Posix)
    /// * `TRUNCATE_EXISTING` (Windows)
    static let truncate = BL_FILE_OPEN_TRUNCATE
    
    /// Opens the file for reading in exclusive mode (Windows).
    /// 
    /// Exclusive mode means to not specify the `FILE_SHARE_READ` option.
    static let readExclusive = BL_FILE_OPEN_READ_EXCLUSIVE
    
    /// Opens the file for writing in exclusive mode (Windows).
    /// 
    /// Exclusive mode means to not specify the `FILE_SHARE_WRITE` option.
    static let writeExclusive = BL_FILE_OPEN_WRITE_EXCLUSIVE
    
    /// Opens the file for both reading and writing (Windows).
    /// 
    /// This is a combination of both `BLFileOpenFlags.readExclusive` and
    /// `BLFileOpenFlags.writeExclusive`.
    static let rwExclusive = BL_FILE_OPEN_RW_EXCLUSIVE
    
    /// Creates the file in exclusive mode - fails if the file already exists.
    /// 
    /// The following system flags are used when opening the file:
    /// * `O_EXCL` (Posix)
    /// * `CREATE_NEW` (Windows)
    static let createExclusive = BL_FILE_OPEN_CREATE_EXCLUSIVE
    
    /// Opens the file for deleting or renaming in exclusive mode (Windows).
    /// 
    /// Exclusive mode means to not specify the `FILE_SHARE_DELETE` option.
    static let deleteExclusive = BL_FILE_OPEN_DELETE_EXCLUSIVE
}
