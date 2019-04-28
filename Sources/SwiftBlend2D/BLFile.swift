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
        try path.withCString { pointer -> Void in
            try resultToError(
                blFileOpen(&object, pointer, flags.rawValue)
            )
        }
    }
    
    @discardableResult
    public func seek(offset: Int64, type: BLFileSeek) throws -> Int64 {
        var positionOut: Int64 = 0
        try resultToError(
            blFileSeek(&object, offset, type.rawValue, &positionOut)
        )
        
        return positionOut
    }
    
    @discardableResult
    public func write(data: [UInt8]) throws -> Int {
        return try data.withUnsafeBytes { pointer in
            try write(buffer: pointer)
        }
    }
    
    #if canImport(Foundation)
    
    @discardableResult
    public func write<T: ContiguousBytes>(data: T) throws -> Int {
        return try data.withUnsafeBytes { pointer in
            try write(buffer: pointer)
        }
    }
    
    #endif
    
    func write(buffer: UnsafeRawBufferPointer) throws -> Int {
        var bytesWritten = 0
        
        if let rawPointer = buffer.baseAddress {
            try resultToError(
                blFileWrite(&object, rawPointer, buffer.count, &bytesWritten)
            )
        }
        
        return bytesWritten
    }
    
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
