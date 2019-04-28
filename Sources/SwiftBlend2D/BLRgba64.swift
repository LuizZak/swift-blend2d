import blend2d

public extension BLRgba64 {
    /// Get whether the color is fully-opaque (alpha equals 0xFFFF).
    @inlinable
    var isOpaque: Bool { return value >= 0xFFFF000000000000 }
    /// Get whether the color is fully-transparent (alpha equals 0).
    @inlinable
    var isTransparent: Bool { return value <= 0x0000FFFFFFFFFFFF }
    
    @inlinable
    init(argb: UInt64) {
        self.init(.init(value: argb))
    }
    
    @inlinable
    init(r: UInt32, g: UInt32, b: UInt32, a: UInt32 = 0xFFFF) {
        self.init(.init(value: (UInt64(a) << 48) | (UInt64(r) << 32) | (UInt64(g) << 16) | UInt64(b)))
    }
    
    @inlinable
    init(rgba32: BLRgba32) {
        self.init(r: rgba32.r | (rgba32.r << 8),
                  g: rgba32.g | (rgba32.g << 8),
                  b: rgba32.b | (rgba32.b << 8),
                  a: rgba32.a | (rgba32.a << 8))
    }
}

extension BLRgba64: Equatable {
    @inlinable
    public static func ==(lhs: BLRgba64, rhs: BLRgba64) -> Bool {
        return lhs.value == rhs.value
    }
}
