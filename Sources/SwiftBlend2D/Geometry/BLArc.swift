import blend2d

public extension BLArc {
    @inlinable
    init(center: BLPoint, radius: BLPoint, start: Double, sweep: Double) {
        self.init(
            cx: center.x,
            cy: center.y,
            rx: radius.x,
            ry: radius.y,
            start: start,
            sweep: sweep
        )
    }
}
