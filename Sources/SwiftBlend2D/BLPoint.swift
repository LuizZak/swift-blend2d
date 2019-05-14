import blend2d

public extension BLPoint {
    /// A zero-valued BLPoint with coordinates (0, 0)
    static let zero = BLPoint(x: 0, y: 0)

    /// A one-valued BLPoint with coordinates (1, 1)
    static let one = BLPoint(x: 1, y: 1)
    
    @inlinable
    init(_ point: BLPointI) {
        self.init(x: Double(point.x), y: Double(point.y))
    }
}

// MARK: - Operators
public extension BLPoint {
    static func +(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func -(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func *(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    static func /(lhs: BLPoint, rhs: BLPoint) -> BLPoint {
        return BLPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    static func +=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs + rhs
    }

    static func -=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs - rhs
    }

    static func *=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs * rhs
    }

    static func /=(lhs: inout BLPoint, rhs: BLPoint) {
        lhs = lhs / rhs
    }
}

// MARK: - Equatable
extension BLPoint: Equatable {
    @inlinable
    public static func ==(lhs: BLPoint, rhs: BLPoint) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}
