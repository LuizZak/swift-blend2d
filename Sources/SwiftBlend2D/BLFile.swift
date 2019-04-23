#if canImport(Foundation)
import Foundation
#endif
import blend2d

/// A thin abstraction over a native OS file IO [C++ API].
///
/// A thin wrapper around a native OS file support. The file handle is always
/// `intptr_t` and it refers to either a file descriptor on POSIX targets and
/// file handle on Windows targets.
public final class BLFile: BLBaseClass<BLFileCore> {
    public var size: UInt64 {
        if !isOpen() {
            return 0
        }
        
        var size: UInt64 = 0
        blFileGetSize(&object, &size)
        
        return size
    }
    
    public override init() {
        super.init()
        
        object.handle = -1
    }
    
    public func isOpen() -> Bool {
        return object.handle != -1
    }
    
    public func open(fileAt path: String, flags: BLFileOpenFlags) throws {
        let pathUtf8 = Array(path.utf8CString)
        
        try resultToError(
            blFileOpen(&object, pathUtf8, flags.rawValue)
        )
    }
    
    @discardableResult
    public func seek(offset: Int64, type: BLFileSeek) throws -> Int64 {
        var positionOut: Int64 = 0
        try resultToError(
            blFileSeek(&object, offset, type.rawValue, &positionOut)
        )
        
        return positionOut
    }
    
    #if canImport(Foundation)
    
    public func write(data: Data) throws -> Int {
        return try data.withUnsafeBytes { pointer in
            guard let rawPointer = pointer.baseAddress else {
                return 0
            }
            
            var bytesWritten = 0
            
            try resultToError(
                blFileWrite(&object, rawPointer, pointer.count, &bytesWritten)
            )
            
            return bytesWritten
        }
    }
    
    #endif
    
    public func truncate(maxSize: Int64) throws {
        try resultToError(
            blFileTruncate(&object, maxSize)
        )
    }
}

extension BLFileCore: CoreStructure {
    public static let initializer = blFileInit
    public static let deinitializer = blFileReset
}
