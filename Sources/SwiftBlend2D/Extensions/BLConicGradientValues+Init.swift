import blend2d

public extension BLConicGradientValues {
    @inlinable
    init(x0: Double, y0: Double, angle: Double) {
        self.init(x0: x0, y0: y0, angle: angle, repeat: 1.0)
    }
}
