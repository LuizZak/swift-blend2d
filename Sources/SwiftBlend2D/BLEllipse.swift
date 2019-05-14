import blend2d

public extension BLEllipse {
    @inlinable
    init(center: BLPoint, radius: BLPoint) {
        self.init(cx: center.x, cy: center.y, rx: radius.x, ry: radius.y)
    }

    func insetBy(x: Double, y: Double) -> BLEllipse {
        return BLEllipse(cx: self.cx + x / 2, cy: self.cy + y / 2, rx: rx - x, ry: ry - y)
    }
}

extension BLEllipse: Equatable {
    @inlinable
    public static func ==(lhs: BLEllipse, rhs: BLEllipse) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.rx == rhs.rx
            && lhs.ry == rhs.ry
    }
}
