import blend2d

public extension BLGradientStop {
    @inlinable
    init(offset: Double, rgba: BLRgba32) {
        self.init(offset: offset, rgba: BLRgba64(rgba32: rgba))
    }
}

extension BLGradientStop: Equatable {
    @inlinable
    public static func ==(lhs: BLGradientStop, rhs: BLGradientStop) -> Bool {
        return lhs.offset == rhs.offset
            && lhs.rgba == rhs.rgba
    }
}
