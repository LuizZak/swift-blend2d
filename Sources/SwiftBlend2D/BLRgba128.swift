import blend2d

public extension BLRgba128 {
    /// Get whether the color is fully-opaque (alpha equals 1.0).
    @inlinable
    var isOpaque: Bool { return a >= 1.0 }
    /// Get whether the color is fully-transparent (alpha equals 0.0).
    @inlinable
    var isTransparent: Bool { return a == 0.0 }

    func withTransparency(_ alpha: Float) -> BLRgba128 {
        return BLRgba128(r: r, g: g, b: b, a: alpha)
    }

    func faded(towards otherColor: BLRgba128, factor: Float, blendAlpha: Bool = false) -> BLRgba128 {
        let from = 1 - factor

        let a = blendAlpha ? self.a * from + otherColor.a * factor : self.a
        let r = self.r * from + otherColor.r * factor
        let g = self.g * from + otherColor.g * factor
        let b = self.b * from + otherColor.b * factor

        return BLRgba128(r: r, g: g, b: b, a: a)
    }
}

extension BLRgba128: Equatable {
    @inlinable
    public static func == (lhs: BLRgba128, rhs: BLRgba128) -> Bool {
        return lhs.r == rhs.r
            && lhs.g == rhs.g
            && lhs.b == rhs.b
            && lhs.a == rhs.a
    }
}
