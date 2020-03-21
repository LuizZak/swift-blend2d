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
    
//    @inlinable
    init(r: UInt32, g: UInt32, b: UInt32, a: UInt32 = 0xFFFF) {
        self.init(.init(.init(b: b, g: g, r: r, a: a)))
    }
    
    // Note: Not @inlinable for now because this currently crashes the Swift
    // compiler: https://bugs.swift.org/browse/SR-10571
//    @inlinable
    init(_ rgba32: BLRgba32) {
        self.init(r: rgba32.r | (rgba32.r << 8),
                  g: rgba32.g | (rgba32.g << 8),
                  b: rgba32.b | (rgba32.b << 8),
                  a: rgba32.a | (rgba32.a << 8))
    }

    func withTransparency(_ alpha: UInt32) -> BLRgba64 {
        var value = self
        value.a = alpha
        return value
    }

    // Currently produces invalid results due to a bug possibly in BLRgba64's
    // storage
//    func faded(towards otherColor: BLRgba64, factor: Double, blendAlpha: Bool = false) -> BLRgba64 {
//        let from = 1 - factor
//
//        let a = UInt32(blendAlpha ? Double(self.a) * from + Double(otherColor.a) * factor : Double(self.a))
//        let r = UInt32(Double(self.r) * from + Double(otherColor.r) * factor)
//        let g = UInt32(Double(self.g) * from + Double(otherColor.g) * factor)
//        let b = UInt32(Double(self.b) * from + Double(otherColor.b) * factor)
//
//        return BLRgba64(r: r, g: g, b: b, a: a)
//    }
}

extension BLRgba64: Equatable {
    @inlinable
    public static func == (lhs: BLRgba64, rhs: BLRgba64) -> Bool {
        return lhs.value == rhs.value
    }
}

extension BLRgba64: CustomStringConvertible {
    public var description: String {
        return "{ a: \(a), r: \(r), g: \(g), b: \(b) }"
    }
}
