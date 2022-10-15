import blend2d

public extension BLRgba {
    /// Get whether the color is fully-opaque (alpha equals 1.0).
    @inlinable
    var isOpaque: Bool { return a >= 1.0 }
    /// Get whether the color is fully-transparent (alpha equals 0.0).
    @inlinable
    var isTransparent: Bool { return a == 0.0 }

    init(_ rgba32: BLRgba32) {
        let r = Float(rgba32.r) * (1.0 / 255.0)
        let g = Float(rgba32.g) * (1.0 / 255.0)
        let b = Float(rgba32.b) * (1.0 / 255.0)
        let a = Float(rgba32.a) * (1.0 / 255.0)
        
        self.init(r: r, g: g, b: b, a: a)
    }

    init(_ rgba64: BLRgba64) {
        let r = Float(rgba64.r) * (1.0 / 65535.0)
        let g = Float(rgba64.g) * (1.0 / 65535.0)
        let b = Float(rgba64.b) * (1.0 / 65535.0)
        let a = Float(rgba64.a) * (1.0 / 65535.0)
        
        self.init(r: r, g: g, b: b, a: a)
    }
    
    func withTransparency(_ alpha: Float) -> BLRgba {
        return BLRgba(r: r, g: g, b: b, a: alpha)
    }

    func faded(
        towards otherColor: BLRgba,
        factor: Float,
        blendAlpha: Bool = false
    ) -> BLRgba {

        let from = 1 - factor

        let a = blendAlpha ? self.a * from + otherColor.a * factor : self.a
        let r = self.r * from + otherColor.r * factor
        let g = self.g * from + otherColor.g * factor
        let b = self.b * from + otherColor.b * factor

        return BLRgba(r: r, g: g, b: b, a: a)
    }
}

extension BLRgba {
    @inlinable
    public static func == (lhs: BLRgba, rhs: BLRgba32) -> Bool {
        lhs == BLRgba(rhs)
    }
    @inlinable
    public static func == (lhs: BLRgba32, rhs: BLRgba) -> Bool {
        BLRgba(lhs) == rhs
    }
    
    @inlinable
    public static func == (lhs: BLRgba, rhs: BLRgba64) -> Bool {
        lhs == BLRgba(rhs)
    }
    @inlinable
    public static func == (lhs: BLRgba64, rhs: BLRgba) -> Bool {
        BLRgba(lhs) == rhs
    }
}
