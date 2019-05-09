import blend2d

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
