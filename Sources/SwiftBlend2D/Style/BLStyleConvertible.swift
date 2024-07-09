import blend2d

/// Specifies an object that is convertible to a `BLStyle` object.
public protocol BLStyleConvertible {
    /// Converts this style-convertible object into a `BLStyle`.
    var asBLStyle: BLStyle { get }
}

extension BLPattern: BLStyleConvertible {
    public var asBLStyle: BLStyle {
        .pattern(self)
    }
}

extension BLGradient: BLStyleConvertible {
    public var asBLStyle: BLStyle {
        .gradient(self)
    }
}

extension BLRgba: BLStyleConvertible {
    public var asBLStyle: BLStyle {
        .rgba(self)
    }
}
