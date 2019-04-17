import blend2d

public extension BLCircle {
    init(center: BLPoint, radius: Double) {
        self.init(cx: center.x, cy: center.y, r: radius)
    }
}

extension BLCircle: Equatable {
    public static func ==(lhs: BLCircle, rhs: BLCircle) -> Bool {
        return lhs.cx == rhs.cx
            && lhs.cy == rhs.cy
            && lhs.r == rhs.r
    }
}
