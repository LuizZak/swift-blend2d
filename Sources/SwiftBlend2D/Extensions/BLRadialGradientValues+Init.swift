import blend2d

public extension BLRadialGradientValues {
    @inlinable
    init(x0: Double, y0: Double, x1: Double, y1: Double, r0: Double) {
        self.init(x0: x0, y0: y0, x1: x1, y1: y1, r0: r0, r1: 0.0)
    }
}
