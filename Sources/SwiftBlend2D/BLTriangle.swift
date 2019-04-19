import blend2d

public extension BLTriangle {
    @inlinable
    init(p0: BLPoint, p1: BLPoint, p2: BLPoint) {
        self.init(x0: p0.x, y0: p0.y,
                  x1: p1.x, y1: p1.y,
                  x2: p2.x, y2: p2.y)
    }
}

extension BLTriangle: Equatable {
    @inlinable
    public static func ==(lhs: BLTriangle, rhs: BLTriangle) -> Bool {
        return lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
            && lhs.x2 == rhs.x2
            && lhs.y2 == rhs.y2
    }
}
