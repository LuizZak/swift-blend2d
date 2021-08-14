import blend2d

public extension BLArc {
    @inlinable
    init(center: BLPoint, radius: BLPoint, start: Double, sweep: Double) {
        self.init(cx: center.x, cy: center.y, rx: radius.x, ry: radius.y, start: start, sweep: sweep)
    }
}

// MARK: - Equatable
extension BLArc: Equatable {
    @inlinable
    public static func == (lhs: BLArc, rhs: BLArc) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
            && lhs.start == rhs.start
            && lhs.sweep == rhs.sweep
    }
}

// MARK: - Hashable
extension BLArc: Hashable {
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cx)
        hasher.combine(cy)
        hasher.combine(rx)
        hasher.combine(ry)
        hasher.combine(start)
        hasher.combine(sweep)
    }
}

// MARK: - CustomStringConvertible
extension BLArc: CustomStringConvertible {
    public var description: String {
        return "BLArc(cx: \(cx), cy: \(cy), rx: \(rx), ry: \(ry), start: \(start), sweep: \(sweep))"
    }
}
