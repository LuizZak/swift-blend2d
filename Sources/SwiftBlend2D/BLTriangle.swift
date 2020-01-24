import blend2d

public extension BLTriangle {
    @inlinable
    init(p0: BLPoint, p1: BLPoint, p2: BLPoint) {
        self.init(x0: p0.x, y0: p0.y,
                  x1: p1.x, y1: p1.y,
                  x2: p2.x, y2: p2.y)
    }

    @inlinable
    func contains(x: Double, y: Double) -> Bool {
        func sign(_ p1x: Double, _ p1y: Double, _ p2x: Double,
                  _ p2y: Double, _ p3x: Double, _ p3y: Double) -> Double {

            return (p1x - p3x) * (p2y - p3y) - (p2x - p3x) * (p1y - p3y)
        }

        let d1 = sign(x, y, x0, y0, x1, y1)
        let d2 = sign(x, y, x1, y1, x2, y2)
        let d3 = sign(x, y, x2, y2, x0, y0)

        let has_neg = (d1 < 0) || (d2 < 0) || (d3 < 0)
        let has_pos = (d1 > 0) || (d2 > 0) || (d3 > 0)

        return !(has_neg && has_pos)
    }

    @inlinable
    func contains(_ point: BLPoint) -> Bool {
        return contains(x: point.x, y: point.y)
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

extension BLTriangle: CustomStringConvertible {
    public var description: String {
        return "BLTriangle(x0: \(x0), y0: \(y0), x1: \(x1), y1: \(y1), x2: \(x2), y2: \(y2))"
    }
}
