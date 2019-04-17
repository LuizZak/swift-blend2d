import blend2d

public extension BLArc {
    init(center: BLPoint, radius: BLPoint, start: Double, sweep: Double) {
        self.init(cx: center.x, cy: center.y, rx: radius.x, ry: radius.y, start: start, sweep: sweep)
    }
}

extension BLArc: Equatable {
    public static func ==(lhs: BLArc, rhs: BLArc) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
            && lhs.start == rhs.start
            && lhs.sweep == rhs.sweep
    }
}
