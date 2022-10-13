import Foundation
import blend2d

public extension BLFormatInfo {
    static var none: BLFormatInfo {
        blFormatInfo.0
    }
    static var prgb32: BLFormatInfo {
        blFormatInfo.1
    }
    static var xrgb32: BLFormatInfo {
        blFormatInfo.2
    }
    static var a8: BLFormatInfo {
        blFormatInfo.3
    }
    
    init?(query format: BLFormat) {
        self.init()
        if blFormatInfoQuery(&self, format) != BL_SUCCESS.rawValue {
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
    public static func == (lhs: BLFormatInfo, rhs: BLFormatInfo) -> Bool {
        withUnsafePointer(to: lhs) { lhs_p in
            withUnsafePointer(to: rhs) { rhs_p in
                memcmp(lhs_p, rhs_p, MemoryLayout<Self>.size) == 0
            }
        }
    }
}
