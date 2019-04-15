import blend2d

public extension BLTriangle {
    init(p0: BLPoint, p1: BLPoint, p2: BLPoint) {
        self.init(.init(p0: p0), .init(p1: p1), .init(p2: p2))
    }
    
    init(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double) {
        self.init(.init(.init(x0: x0, y0: y0)),
                  .init(.init(x1: x1, y1: y1)),
                  .init(.init(x2: x2, y2: y2)))
    }
}

extension BLTriangle: Equatable {
    public static func ==(lhs: BLTriangle, rhs: BLTriangle) -> Bool {
        return lhs.p0 == rhs.p0
            && lhs.p1 == rhs.p1
            && lhs.p2 == rhs.p2
    }
}
