import blend2d

public extension BLLine {
    @inlinable
    init(start: BLPoint, end: BLPoint) {
        self.init(x0: start.x, y0: start.y, x1: end.x, y1: end.y)
    }
}

extension BLLine: Equatable {
    @inlinable
    public static func ==(lhs: BLLine, rhs: BLLine) -> Bool {
        return lhs.x0 == rhs.x0
            && lhs.y0 == rhs.y0
            && lhs.x1 == rhs.x1
            && lhs.y1 == rhs.y1
    }
}
