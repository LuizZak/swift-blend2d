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
