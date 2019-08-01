import blend2d

public extension BLRgba32 {
    /// Get whether the color is fully-opaque (alpha equals 0xFFFF).
    @inlinable
    var isOpaque: Bool { return value >= 0xFF000000 }
    /// Get whether the color is fully-transparent (alpha equals 0).
    @inlinable
    var isTransparent: Bool { return value <= 0x00FFFFFF }
    
    @inlinable
    init(argb: UInt32) {
        self.init(.init(value: argb))
    }
    
    @inlinable
    init(r: UInt32, g: UInt32, b: UInt32, a: UInt32 = 0xFF) {
        self.init(.init(value: (a << 24) | (r << 16) | (g <<  8) | b))
    }
    
    @inlinable
    init(rgba64: BLRgba64) {
        let hi = UInt32(rgba64.value >> 32)
        let lo = UInt32(rgba64.value & 0xFFFFFFFF)
        
        self.init(argb: (hi & 0xFF000000)
            + ((lo & 0xFF000000) >> 16)
            + ((hi & 0x0000FF00) <<  8)
            + ((lo & 0x0000FF00) >>  8))
    }

    func withTransparency(_ alpha: UInt32) -> BLRgba32 {
        return BLRgba32(r: r, g: g, b: b, a: alpha)
    }
}

extension BLRgba32: Equatable {
    @inlinable
    public static func ==(lhs: BLRgba32, rhs: BLRgba32) -> Bool {
        return lhs.value == rhs.value
    }
}
