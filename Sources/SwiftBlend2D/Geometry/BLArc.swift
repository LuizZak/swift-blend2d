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

// MARK: - CustomStringConvertible
extension BLArc: CustomStringConvertible {
    public var description: String {
        return "BLArc(cx: \(cx), cy: \(cy), rx: \(rx), ry: \(ry), start: \(start), sweep: \(sweep))"
    }
}
