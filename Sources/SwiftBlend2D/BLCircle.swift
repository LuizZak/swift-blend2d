import blend2d

public extension BLCircle {
    @inlinable
    init(center: BLPoint, radius: Double) {
        self.init(cx: center.x, cy: center.y, r: radius)
    }

    @inlinable
    func expanding(by value: Double) -> BLCircle {
        return BLCircle(cx: cx, cy: cy, r: r + value)
    }
}

extension BLCircle: Equatable {
    @inlinable
    public static func ==(lhs: BLCircle, rhs: BLCircle) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.r == rhs.r
    }
}
