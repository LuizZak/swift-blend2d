import blend2d

public extension BLFormatInfo {
    static var none: BLFormatInfo {
        return blFormatInfo.0
    }
    static var prgb32: BLFormatInfo {
        return blFormatInfo.1
    }
    static var xrgb32: BLFormatInfo {
        return blFormatInfo.2
    }
    static var a8: BLFormatInfo {
        return blFormatInfo.3
    }
    
    init?(query format: BLFormat) {
        self.init()
        if blFormatInfoQuery(&self, format.rawValue) != BL_SUCCESS.rawValue {
            return nil
        }
    }
    
    /// Sanitize this `BLFormatInfo`.
    ///
    /// Sanitizer verifies whether the format is valid and updates the format
    /// information about flags to values that Blend2D expects. For example
    /// format flags are properly examined and simplified if possible, byte-swap
    /// is implicitly performed for formats where a single component matches one
    /// byte, etc...
    mutating func sanitize() throws {
        try resultToError(blFormatInfoSanitize(&self))
    }
}

extension BLFormatInfo: Equatable {
    public static func ==(lhs: BLFormatInfo, rhs: BLFormatInfo) -> Bool {
        if lhs.depth != rhs.depth || lhs.flags != rhs.flags {
            return false
        }
        
        if BLFormatFlags(lhs.flags).contains(.indexed) {
            return lhs.palette == rhs.palette
        }
        
        return lhs.shifts == rhs.shifts && lhs.sizes == rhs.sizes
    }
}
