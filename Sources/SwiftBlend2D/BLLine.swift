import blend2d

public extension BLLine {
    init(start: BLPoint, end: BLPoint) {
        self.init(.init(p0: start), .init(p1: end))
    }
    
    init(startX: Double, startY: Double, endX: Double, endY: Double) {
        self.init(.init(.init(x0: startX, y0: startY)),
                  .init(.init(x1: endX, y1: endY)))
    }
}

extension BLLine: Equatable {
    public static func ==(lhs: BLLine, rhs: BLLine) -> Bool {
        return lhs.p0 == rhs.p0 && lhs.p1 == rhs.p1
    }
}
