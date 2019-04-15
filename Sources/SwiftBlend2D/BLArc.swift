import blend2d

public extension BLArc {
    init(center: BLPoint, radius: BLPoint, start: Double, sweep: Double) {
        self.init(.init(center: center), .init(radius: radius), start: start, sweep: sweep)
    }
    
    init(cx: Double, cy: Double, rx: Double, ry: Double, start: Double, sweep: Double) {
        self.init(.init(.init(cx: cx, cy: cy)), .init(.init(rx: rx, ry: ry)), start: start, sweep: sweep)
    }
}

extension BLArc: Equatable {
    public static func ==(lhs: BLArc, rhs: BLArc) -> Bool {
        return lhs.center == rhs.center
            && lhs.radius == rhs.radius
            && lhs.start == rhs.start
            && lhs.sweep == rhs.sweep
    }
}
