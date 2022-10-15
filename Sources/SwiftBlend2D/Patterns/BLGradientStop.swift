import blend2d

public extension BLGradientStop {
    @inlinable
    init(offset: Double, rgba: BLRgba32) {
        self.init(offset: offset, rgba: BLRgba64(rgba))
    }
}
