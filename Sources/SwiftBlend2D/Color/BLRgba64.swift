import blend2d

public extension BLRgba64 {
    /// Get whether the color is fully-opaque (alpha equals 0xFFFF).
    @inlinable
    var isOpaque: Bool { return value >= 0xFFFF000000000000 }
    /// Get whether the color is fully-transparent (alpha equals 0).
    @inlinable
    var isTransparent: Bool { return value <= 0x0000FFFFFFFFFFFF }
    
    var r: UInt32 {
        get {
            UInt32((value >> 32) & 0xFFFF)
        }
        set {
            value = (value & 0xFFFF0000FFFFFFFF) | (UInt64(newValue) << 32)
        }
    }

    var g: UInt32 {
        get {
            UInt32((value >> 16) & 0xFFFF)
        }
        set {
            value = (value & 0xFFFFFFFF0000FFFF) | (UInt64(newValue) << 16)
        }
    }

    var b: UInt32 {
        get {
            UInt32((value >> 0) & 0xFFFF)
        }
        set {
            value = (value & 0xFFFFFFFFFFFF0000) | (UInt64(newValue) <<  0)
        }
    }

    var a: UInt32 {
        get {
            UInt32(value >> 48)
        }
        set {
            value = (value & 0x0000FFFFFFFFFFFF) | (UInt64(newValue) << 48)
        }
    }

    @inlinable
    init(argb: UInt64) {
        self.init(value: argb)
    }
    
    @inlinable
    init(r: UInt32, g: UInt32, b: UInt32, a: UInt32 = 0xFFFF) {
        self.init(value: (UInt64(a) << 48) | (UInt64(r) << 32) | (UInt64(g) << 16) | (UInt64(b) <<  0))
    }
    
    // Note: Not @inlinable for now because this currently crashes the Swift
    // compiler: https://bugs.swift.org/browse/SR-10571
//    @inlinable
    init(_ rgba32: BLRgba32) {
        let value: UInt64 = 
            (UInt64(rgba32.r) << 32) |
            (UInt64(rgba32.g) << 16) |
            (UInt64(rgba32.b) <<  0) |
            (UInt64(rgba32.a) << 48)

        self.init(value: value * 0x0101)
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
        return "BLRgba64(r: \(r), g: \(g), b: \(b), a: \(a))"
    }
}

public extension BLRgba64 {
    var asBLRgba: BLRgba {
        return BLRgba(self)
    }
}
