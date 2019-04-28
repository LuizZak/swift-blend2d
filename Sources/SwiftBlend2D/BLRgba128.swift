import blend2d

public extension BLRgba128 {
    /// Get whether the color is fully-opaque (alpha equals 1.0).
    @inlinable
    var isOpaque: Bool { return a >= 1.0 }
    /// Get whether the color is fully-transparent (alpha equals 0.0).
    @inlinable
    var isTransparent: Bool { return a == 0.0 }
}

extension BLRgba128: Equatable {
    @inlinable
    public static func ==(lhs: BLRgba128, rhs: BLRgba128) -> Bool {
        return lhs.r == rhs.r
            && lhs.g == rhs.g
            && lhs.b == rhs.b
            && lhs.a == rhs.a
    }
}
