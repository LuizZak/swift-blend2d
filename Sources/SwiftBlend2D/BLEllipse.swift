import blend2d

public extension BLEllipse {
    @inlinable
    init(center: BLPoint, radius: BLPoint) {
        self.init(cx: center.x, cy: center.y, rx: radius.x, ry: radius.y)
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
